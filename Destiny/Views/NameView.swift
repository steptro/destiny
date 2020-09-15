import SwiftUI

struct NameView: View {
    @State private var names: [String] = []
    
    @State private var showAlert = false
    @State private var pickedWinner = false

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        self.showAlert = true
                    }) {
                        HStack {
                            Image(systemName: "plus")
                            Text("Add name")
                        }
                    }
                    Spacer()
                    Button(action: {
                        self.pickedWinner = true
                    }) {
                        HStack {
                            Image(systemName: "bolt")
                            Text("Start")
                        }
                    }
                    .padding(.leading, 20).padding(.top, 5).padding(.bottom, 5).padding(.trailing, 20)
                    .foregroundColor(.red)
                    .cornerRadius(10)
                }
                .padding(.leading, 20).padding(.trailing, 20).font(Font.body.bold())
                Divider()
                
                if names.count > 0 {
                    List {
                        ForEach((0..<names.count), id: \.self) { i in
                            Text(self.names[i])
                        }.onDelete(perform: deleteItems)
                    }
                } else {
                    Spacer()
                    Text("No names added yet.")
                }
            
                Spacer()
            }
            .alert(isPresented: $showAlert, TextAlert(title: "Add name", action: {
                let name = $0
                
                if name != nil && name!.count != 0 {
                    self.names.append(name!)
                }
                
                print("Callback \($0 ?? "<cancel>")")
            }))
            .alert(isPresented: $pickedWinner) {
                Alert(title: Text("Winner"), message: Text(self.pickName()))
            }
            .navigationBarTitle("Name picker")
        }
    }
    
    func pickName() -> String {
        return self.names[Int.random(in: 0..<self.names.count)]
    }
    
    func deleteItems(at offsets: IndexSet) {
        names.remove(atOffsets: offsets)
    }
}

struct NameView_Previews: PreviewProvider {
    static var previews: some View {
        NameView()
    }
}
