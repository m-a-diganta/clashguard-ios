import Foundation

enum TimelineItem: Identifiable {
    case shift(RosterShift)
    case deadline(AcademicDeadline)

    var id: String {
        switch self {
        case .shift(let shift): return "shift-\(shift.id)"
        case .deadline(let deadline): return "deadline-\(deadline.id)"
        }
    }

    var date: Date {
        switch self {
        case .shift(let shift): return shift.startTime
        case .deadline(let deadline): return deadline.dueAt
        }
    }
}

class MergedCalendarViewModel: ObservableObject {
    @Published var shifts: [RosterShift] = []
    @Published var deadlines: [AcademicDeadline] = []

    var timeline: [TimelineItem] {
        let shiftItems = shifts.map { TimelineItem.shift($0) }
        let deadlineItems = deadlines.map { TimelineItem.deadline($0) }
        return (shiftItems + deadlineItems).sorted { $0.date < $1.date }
    }
}
