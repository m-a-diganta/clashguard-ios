import SwiftUI

struct ContentView: View {
    @StateObject private var importViewModel = ImportViewModel()
    @StateObject private var calendarViewModel = MergedCalendarViewModel()
    @StateObject private var clashAlertViewModel = ClashAlertViewModel()
    @StateObject private var swapBoardViewModel = SwapBoardViewModel()

    var body: some View {
        TabView {
            ImportView(viewModel: importViewModel, onImport: importSampleData)
                .tabItem {
                    Label("Import", systemImage: "square.and.arrow.down")
                }

            MergedCalendarView(viewModel: calendarViewModel)
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }

            ClashAlertView(viewModel: clashAlertViewModel, swapBoardViewModel: swapBoardViewModel)
                .tabItem {
                    Label("Clashes", systemImage: "exclamationmark.triangle")
                }

            SwapBoardView(viewModel: swapBoardViewModel)
                .tabItem {
                    Label("Swap Board", systemImage: "arrow.left.arrow.right")
                }
        }
    }

    private func importSampleData() {
        calendarViewModel.shifts = importViewModel.shifts
        calendarViewModel.deadlines = importViewModel.deadlines
        clashAlertViewModel.loadClashes(
            shifts: calendarViewModel.shifts,
            deadlines: calendarViewModel.deadlines
        )
    }
}

#Preview {
    ContentView()
}
