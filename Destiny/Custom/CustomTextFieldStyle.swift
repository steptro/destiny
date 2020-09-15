import SwiftUI

public struct CustomTextFieldStyle : TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.body)
            .padding(15)
            
            //Give it some style
            .background(
                RoundedRectangle(cornerRadius: 5).strokeBorder(Color.primary.opacity(0.5), lineWidth: 1)
            )
    }
}
