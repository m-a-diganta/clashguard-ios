import SwiftUI

struct MergedCalendarView: View {
    @ObservedObject var viewModel: MergedCalendarViewModel

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE d MMM"
        return formatter
    }()

    private static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mma"
        return formatter
    }()

    var body: some View {
        NavigationStack {
            List(viewModel.timeline) { item in
                row(for: item)
            }
            .navigationTitle("This week")
            .overlay {
                if viewModel.timeline.isEmpty {
                    ContentUnavailableView("Nothing imported yet", systemImage: "calendar")
                }
            }
        }
    }

    @ViewBuilder
    private func row(for item: TimelineItem) -> some View {
        switch item {
        case .shift(let shift):
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(shift.roleTitle).bold()
                    Spacer()
                    tag("Shift", color: .teal)
                }
                Text(shift.workplace)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(
                    "\(Self.dateFormatter.string(from: shift.startTime)), " +
                    "\(Self.timeFormatter.string(from: shift.startTime)) - " +
                    "\(Self.timeFormatter.string(from: shift.endTime))"
                )
                .font(.caption)
                .foregroundStyle(.secondary)
            }
            .padding(.vertical, 4)

        case .deadline(let deadline):
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(deadline.title).bold()
                    Spacer()
                    tag(deadline.type.rawValue.capitalized, color: .orange)
                }
                Text("Due \(Self.dateFormatter.string(from: deadline.dueAt)), \(Self.timeFormatter.string(from: deadline.dueAt))")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, 4)
        }
    }

    private func tag(_ label: String, color: Color) -> some View {
        Text(label)
            .font(.caption2)
            .bold()
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background(color.opacity(0.2))
            .foregroundStyle(color)
            .clipShape(Capsule())
    }
}

#Preview {
    let vm = MergedCalendarViewModel()
    vm.shifts = SampleData.shifts()
    vm.deadlines = SampleData.deadlines()
    return MergedCalendarView(viewModel: vm)
}
