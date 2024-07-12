import SwiftUI

struct HistoryView: View {
    
    @StateObject var viewModel = HistoryViewModel()
    @Environment(\.dismiss) private var dismiss
    @State var selectedFilter: Filter?
    let useFilter: (_ filter: Filter) -> ()
    
    var body: some View {
        ZStack {
            if viewModel.filters.isEmpty {
                Image("Empty")
            } else {
                filtersList
            }
            VStack {
                topBar
                    .addRVNavigationBarBackground()
                Spacer()
            }
        }
        .background(Color.backgroundOne)
        .navigationBarBackButtonHidden()
        .actionSheet(item: $selectedFilter) { filter in
            ActionSheet(title: Text("Menu Filter"), buttons: [
                .cancel(),
                .default(
                    Text("Use"),
                    action: {
                        useFilter(filter)
                        dismiss()
                    }
                ),
                .destructive(
                    Text("Delete"),
                    action: {
                        withAnimation(.easeInOut) { viewModel.delete(filter: filter) }
                    }
                )
                
            ])
        }
        .alert(viewModel.errorTitle, isPresented: $viewModel.error, actions: {
            Button("OK", role: .cancel) { viewModel.clearError() }
        }, message: { Text(viewModel.errorMessage) })
    }
}

#Preview {
    HistoryView(useFilter: { filter in })
        .environmentObject(HistoryViewModel())
}


// MARK: - UI elements

private extension HistoryView {
    
    var filtersList: some View {
        ScrollView(showsIndicators: false) {
            topBar.opacity(0)
                .padding(20)
            LazyVStack(spacing: 15) {
                ForEach(viewModel.filters) { filter in
                    FilterCardView(filter: filter)
                        .onTapGesture { selectedFilter = filter }
                }
            }
            .padding(.horizontal)
        }
    }
    
    var topBar: some View {
        HStack {
            Button(action: { dismiss() }, label: {
                Image("Left")
            })
            Spacer()
            Text("History")
                .font(.largeTitle.bold())
                .foregroundStyle(Color.layerOne)
            Spacer()
            Image("Left").opacity(0)
        }
    }
}

