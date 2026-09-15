import Foundation

/// How urgent a clash is, ordered from least to most urgent.
enum ClashSeverity: String, Codable, Comparable {
    case advanceWarning
    case dayBefore
    case sameDay

    private var rank: Int {
        switch self {
        case .advanceWarning: return 0
        case .dayBefore: return 1
        case .sameDay: return 2
        }
    }

    static func < (lhs: ClashSeverity, rhs: ClashSeverity) -> Bool {
        lhs.rank < rhs.rank
    }
}

/// A detected conflict between one shift and one deadline.
/// Business rule: severity is set once at detection time, based on the
/// gap between the shift and the deadline, and whether the deadline is
/// high stakes.
struct ClashRecord: Identifiable, Codable, Hashable {
    let id: UUID
    let shift: RosterShift
    let deadline: AcademicDeadline
    let severity: ClashSeverity
    let gapHours: Double
    var isResolved: Bool

    func summary() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mma"
        let shiftStart = formatter.string(from: shift.startTime)
        let shiftEnd = formatter.string(from: shift.endTime)
        return "Shift \(shiftStart)\u{2013}\(shiftEnd) overlaps \(deadline.title)"
    }
}
