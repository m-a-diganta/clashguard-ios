import SwiftUI

struct ClashAlertView: View {
    @ObservedObject var viewModel: ClashAlertViewModel
    @ObservedObject var swapBoardViewModel: SwapBoardViewModel
    @State private var sentClashIDs: Set<UUID> = []

    var body: some View {
        NavigationStack {
            List {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                }

                ForEach(viewModel.clashes) { clash in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(severityLabel(clash.severity))
                            .font(.caption)
                            .bold()
                            .foregroundStyle(severityColor(clash.severity))

                        Text(clash.summary())

                        Button {
                            swapBoardViewModel.flag(clash: clash)
                            sentClashIDs.insert(clash.id)
                        } label: {
                            Text(sentClashIDs.contains(clash.id) ? "Sent to swap board" : "Send to swap board")
                        }
                        .buttonStyle(.bordered)
                        .controlSize(.small)
                        .disabled(sentClashIDs.contains(clash.id))
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Clashes")
            .overlay {
                if viewModel.clashes.isEmpty {
                    ContentUnavailableView("No clashes found", systemImage: "checkmark.circle")
                }
            }
        }
    }

    private func severityLabel(_ severity: ClashSeverity) -> String {
        switch severity {
        case .sameDay: return "Same day clash"
        case .dayBefore: return "Day before clash"
        case .advanceWarning: return "Advance warning"
        }
    }

    private func severityColor(_ severity: ClashSeverity) -> Color {
        switch severity {
        case .sameDay: return .red
        case .dayBefore: return .orange
        case .advanceWarning: return .yellow
        }
    }
}

#Preview {
    ClashAlertView(viewModel: ClashAlertViewModel(), swapBoardViewModel: SwapBoardViewModel())
}
