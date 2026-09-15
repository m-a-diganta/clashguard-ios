import SwiftUI

struct MergedCalendarView: View {
    @ObservedObject var viewModel: MergedCalendarViewModel

    var body: some View {
        NavigationStack {
            List {
                Section("Shifts") {
                    ForEach(viewModel.shifts) { shift in
                        VStack(alignment: .leading) {
                            Text(shift.roleTitle).bold()
                            Text(shift.workplace)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }

                Section("Deadlines") {
                    ForEach(viewModel.deadlines) { deadline in
                        VStack(alignment: .leading) {
                            Text(deadline.title).bold()
                            Text(deadline.type.rawValue.capitalized)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("This week")
            .overlay {
                if viewModel.shifts.isEmpty && viewModel.deadlines.isEmpty {
                    ContentUnavailableView("Nothing imported yet", systemImage: "calendar")
                }
            }
        }
    }
}

#Preview {
    MergedCalendarView(viewModel: MergedCalendarViewModel())
}
