//
//  ContentView.swift
//  Destiny
//
//  Created by Stephan Tromer on 01/09/2020.
//  Copyright © 2020 Stephan Tromer. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var destiny: String = ""
    @State private var selectedOption = 0
    @State private var modalDisplayed = false
    
    var options = [1, 3, 5, 7, 9]
    let defaultPadding: CGFloat = 20
    
    init() {
         UITableView.appearance().tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude))
         UITableView.appearance().tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Which question do you want answered?").fontWeight(.bold)
                    Spacer()
                }
                
                TextField("", text: $destiny).textFieldStyle(CustomTextFieldStyle())
                
                HStack {
                    Text("Best of how many rounds do you want to play?").fontWeight(.bold)
                    Spacer()
                }.padding(.top, defaultPadding)
                
                Picker("Best-of", selection: $selectedOption) {
                    ForEach(0 ..< options.count) {
                        Text(String(self.options[$0]))
                    }
                }.labelsHidden().padding(.top, -75)

                Button("Find out your destiny") {
                    self.modalDisplayed = true
                }.font(.headline).sheet(isPresented: $modalDisplayed) {
                    SheetView(onDismiss: {
                        self.modalDisplayed = false
                    }, destiny: self.destiny)
                }.disabled(destiny.count == 0)
                
                Spacer()
            }
            .padding(defaultPadding)
            .navigationBarTitle("Create your destiny")
        }
        
    }
}

public struct CustomTextFieldStyle : TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.body)
            .padding(15) // Set the inner Text Field Padding
            //Give it some style
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .strokeBorder(Color.primary.opacity(0.5), lineWidth: 1))
    }
}


struct SheetView: View {
    var onDismiss: () -> ()

    @State var destiny: String

    @State private var yesScore = 0
    @State private var noScore = 0

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("\(yesScore)").font(.largeTitle)
                    Text(" - ").font(.largeTitle)
                    Text("\(yesScore)").font(.largeTitle)
                    }.padding(.top, 25)
                Spacer()
            }
            .navigationBarTitle(Text(destiny), displayMode: .inline)
            .navigationBarItems(trailing: Button("Done") {
                self.onDismiss()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.locale, .init(identifier: "en"))
    }

}
