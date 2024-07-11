import SwiftUI

struct FilterButtonView: View {
    
    let imageName: String
    let text: String
    
    var body: some View {
        Color.white
            .frame(height: 40)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .overlay {
                HStack {
                    Image(imageName)
                    Text(text).bold()
                    Spacer()
                }
                .foregroundStyle(Color.layerOne)
                .padding(.horizontal, 10)
            }
    }
}

#Preview {
    ZStack {
        Color.accenOne.ignoresSafeArea()
        HStack {
            FilterButtonView(imageName: "Rover", text: "All")
            FilterButtonView(imageName: "Camera", text: "All")
        }
        .padding()
    }
}
