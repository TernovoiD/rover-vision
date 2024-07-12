import SwiftUI

struct DateSelectorView: View {
    
    @State var date: Date
    let select: (_ date: Date) -> ()
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
                Button(action: { select(date )}, label: {
                    Image("Tick")
                })
            }
            DatePicker("Date", selection: $date, in: ...Date(), displayedComponents: [.date])
                .datePickerStyle(.wheel)
                .colorScheme(.light)
                .labelsHidden()
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
        DateSelectorView(date: Date(), select: { date in }, close: { })
            .padding()
    }
}
