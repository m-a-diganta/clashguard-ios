import SwiftUI

struct ImportView: View {
    @ObservedObject var viewModel: ImportViewModel
    var onImport: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "calendar.badge.exclamationmark")
                .font(.system(size: 40))
                .foregroundStyle(.teal)

            Text("Add your calendars")
                .font(.title2)
                .bold()

            Text("Import your timetable, assessments, and work roster")
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            Button {
                viewModel.importRoster()
                onImport()
            } label: {
                Text(viewModel.didImport ? "Imported" : "Import sample data")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .disabled(viewModel.didImport)
        }
        .padding()
    }
}

#Preview {
    ImportView(viewModel: ImportViewModel(), onImport: {})
}
