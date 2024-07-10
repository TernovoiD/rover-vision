import SwiftUI

struct HomeTopBarView: View {
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("MARS.CAMERA")
                        .font(.largeTitle.bold())
                    Text("June 6, 2019")
                        .font(.body.bold())
                }
                Spacer()
                Image(systemName: "calendar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35, height: 35)
            }
            .foregroundStyle(Color.layerOne)
            
            HStack(spacing: 25) {
                HStack(spacing: 10) {
                    Button(action: {}, label: {
                        Color.white
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                            .overlay {
                                HStack {
                                    Image(systemName: "memorychip.fill")
                                    Text("All")
                                    Spacer()
                                }
                                .foregroundStyle(Color.layerOne)
                                .padding(.horizontal, 10)
                            }
                    })
                    Button(action: {}, label: {
                        Color.white
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                            .overlay {
                                HStack {
                                    Image(systemName: "camera.fill")
                                    Text("All")
                                    Spacer()
                                }
                                .foregroundStyle(Color.layerOne)
                                .padding(.horizontal, 10)
                            }
                    })
                }
                Button(action: {}, label: {
                    Image(systemName: "plus")
                        .frame(width: 35, height: 35)
                        .background(Color.backgroundOne)
                        .foregroundStyle(Color.layerOne)
                        .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                })
            }
            .frame(height: 35)
        }
    }
}

#Preview {
    VStack {
        HomeTopBarView()
            .padding(.horizontal)
            .padding(.bottom)
            .background(
                Color.accenOne
                    .ignoresSafeArea()
                    .shadow(color: .black.opacity(0.4), radius: 3)
            )
        Spacer()
    }
}
