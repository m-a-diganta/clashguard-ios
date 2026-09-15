import Foundation

class MergedCalendarViewModel: ObservableObject {
    @Published var shifts: [RosterShift] = []
    @Published var deadlines: [AcademicDeadline] = []
}
