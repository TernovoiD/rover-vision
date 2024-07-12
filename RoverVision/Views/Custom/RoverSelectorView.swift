import SwiftUI

struct RoverSelectorView: View {
    
    @State var rover: RoverName
    let select: (_ rover: RoverName) -> ()
    let close: () -> ()
    
    var body: some View {
        VStack {
            HStack {
                Button(action: { close() }, label: {
                    Image("Close")
                })
                Spacer()
                Text("Rover")
                    .foregroundStyle(Color.layerOne)
                    .font(.title2.bold())
                Spacer()
                Button(action: { select(rover) }, label: {
                    Image("Tick")
                })
            }
            Picker("Rover name", selection: $rover) {
                ForEach(RoverName.allCases) { name in
                    Text(name.description())
                        .foregroundStyle(Color.layerOne)
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
            RoverSelectorView(rover: .curiosity, select: { rover in }, close: { })
        }.ignoresSafeArea()
    }
}
