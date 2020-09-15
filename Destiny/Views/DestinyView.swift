import SwiftUI

struct DestinyView: View {
    @State private var destiny: String = ""
    @State private var selectedOption = 0
    @State private var modalDisplayed = false
    
    var options = [1, 3, 5, 7, 9]
    let defaultPadding: CGFloat = 20
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Which question do you want answered?").fontWeight(.bold)
                    Spacer()
                }
                
                TextField("Your question", text: $destiny).textFieldStyle(CustomTextFieldStyle())
                
                HStack {
                    Text("Best of how many rounds do you want to play?").fontWeight(.bold)
                    Spacer()
                }.padding(.top, defaultPadding)
                
                Picker(selection: $selectedOption.onChange(dismissKeyboard), label: Text("Best-of")) {
                    ForEach(0 ..< options.count) {
                        Text(String(self.options[$0]))
                    }
                }.labelsHidden().padding(.top, -75)

                Button("Find out your destiny") {
                    self.modalDisplayed = true
                }.font(.headline).sheet(isPresented: $modalDisplayed) {
                    SheetView(bestOf: self.options[self.selectedOption], destiny: self.destiny)
                }.disabled(destiny.count == 0)
                
                Spacer()
            }
            .padding(defaultPadding)
            .navigationBarTitle("Create your destiny")
        }
    }
    
    func dismissKeyboard(_ tag: Int) {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
    }
}

struct SheetView: View {
    @Environment(\.presentationMode) var presentationMode

    var bestOf: Int
    @State var destiny: String
    @State private var winningScore: Int = -1
    @State private var yesScore = 0
    @State private var noScore = 0
    @State private var isWinner = false;
    
    var body: some View {
        NavigationView {
            ZStack {
                ShakableViewRepresentable().allowsHitTesting(false)
                VStack {
                    HStack {
                        Text("\(yesScore)")
                        Text(" - ")
                        Text("\(noScore)")
                    }.padding(.top, 25).font(.system(size: 75))
                    
                    if !isWinner {
                        Text("Shake or click next round to play the next round").font(.callout).padding(.top, 25).padding(.bottom, 10).padding(.leading, 20)
                        Button("Next round") {
                            self.doRound()
                        }
                    }
                    
                    Spacer().alert(isPresented: $isWinner) {
                        Alert(title: Text(destiny), message: Text(yesScore > noScore ? "Yes" : "No"))
                    }
                }
                .navigationBarTitle(Text(destiny), displayMode: .inline)
                .navigationBarItems(trailing: Button("Done") {
                    self.presentationMode.wrappedValue.dismiss()
                })
                    .onReceive(messagePublisher) { _ in
                        self.doRound()
                }
            }
            
        }.onAppear() {
            self.winningScore = Int(Double(self.bestOf / 2).rounded()) + 1
        }
    }
    
    func doRound() {
        let random = Float.random(in: 0 ..< 1)
        if (random > 0.5) {
            yesScore += 1
        } else {
            noScore += 1
        }
        
        if (yesScore == winningScore || noScore == winningScore) {
            isWinner = true
        }
    }
}

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { selection in
                self.wrappedValue = selection
                handler(selection)
        })
    }
}

struct DestinyView_Previews: PreviewProvider {
    static var previews: some View {
        DestinyView().environment(\.locale, .init(identifier: "nl"))
    }
}
