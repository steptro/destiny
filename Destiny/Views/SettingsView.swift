import SwiftUI

struct SettingsView: View {
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String

    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("About".uppercased())) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text(appVersion)
                    }
                    
                }
                
            }
            .navigationBarTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
