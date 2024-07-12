import SwiftUI

struct CameraSelectorView: View {
    
    @State var camera: CameraName?
    let select: (_ camera: CameraName?) -> ()
    let close: () -> ()
    
    var body: some View {
        VStack {
            HStack {
                Button(action: { close() }, label: {
                    Image("Close")
                })
                Spacer()
                Text("Camera")
                    .foregroundStyle(Color.layerOne)
                    .font(.title2.bold())
                Spacer()
                Button(action: { select(camera) }, label: {
                    Image("Tick")
                })
            }
            Picker("Camera name", selection: $camera) {
                Text("All")
                    .tag(CameraName?.none)
                    .foregroundStyle(Color.layerOne)
                ForEach(CameraName.allCases) { name in
                    Text(name.description())
                        .foregroundStyle(Color.layerOne)
                        .tag(CameraName?.some(name))
                }
            }
            .pickerStyle(.wheel)
        }
        .padding()
        .background(Color.backgroundOne
            .clipShape(RoundedRectangle(cornerRadius: 50))
            .shadow(color: .black.opacity(0.3),
                    radius: 10)
        )
    }
}

#Preview {
    ZStack {
        Color.backgroundOne.ignoresSafeArea()
        VStack {
            Spacer()
            CameraSelectorView(camera: .chemcam, select: { camera in }) {
                
            }
        }.ignoresSafeArea()
        
    }
}
