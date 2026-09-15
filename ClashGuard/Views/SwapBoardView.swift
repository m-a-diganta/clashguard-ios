import SwiftUI

struct SwapBoardView: View {
    @ObservedObject var viewModel: SwapBoardViewModel

    var body: some View {
        NavigationStack {
            List {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                }

                ForEach(viewModel.flaggedClashes) { clash in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(clash.shift.roleTitle).bold()
                        Text(clash.shift.workplace)
                            .font(.caption)
                            .foregroundStyle(.secondary)

                        HStack {
                            Button("Offer swap") {}
                                .buttonStyle(.borderedProminent)
                            Button("Offer up") {}
                                .buttonStyle(.bordered)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Flagged shifts")
            .overlay {
                if viewModel.flaggedClashes.isEmpty {
                    ContentUnavailableView("No flagged shifts yet", systemImage: "arrow.left.arrow.right")
                }
            }
        }
    }
}

#Preview {
    SwapBoardView(viewModel: SwapBoardViewModel())
}
