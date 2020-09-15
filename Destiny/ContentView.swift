import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DestinyView().tabItem {
                Image(systemName: "wand.and.stars")
                Text("Destiny")
            }
            NameView().tabItem {
                Image(systemName: "person.3")
                Text("Name picker")
            }
            SettingsView().tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.locale, .init(identifier: "en"))
    }
}
