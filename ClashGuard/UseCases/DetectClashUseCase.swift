import Foundation

enum DetectClashError: LocalizedError {
    case noShiftsProvided
    case noDeadlinesProvided

    var errorDescription: String? {
        switch self {
        case .noShiftsProvided:
            return "No shifts to check. Import your roster first."
        case .noDeadlinesProvided:
            return "No deadlines to check. Import your academic calendar first."
        }
    }
}

/// Compares shifts against deadlines and builds the list of clashes.
struct DetectClashUseCase {
    func execute(shifts: [RosterShift], deadlines: [AcademicDeadline]) throws -> [ClashRecord] {
        guard !shifts.isEmpty else {
            throw DetectClashError.noShiftsProvided
        }
        guard !deadlines.isEmpty else {
            throw DetectClashError.noDeadlinesProvided
        }

        var clashes: [ClashRecord] = []

        for shift in shifts {
            for deadline in deadlines {
                let gapHours = deadline.dueAt.timeIntervalSince(shift.endTime) / 3600

                guard gapHours >= -24 && gapHours <= 24 else {
                    continue
                }

                let clash = ClashRecord(
                    id: UUID(),
                    shift: shift,
                    deadline: deadline,
                    severity: severity(forGapHours: gapHours),
                    gapHours: gapHours,
                    isResolved: false
                )
                clashes.append(clash)
            }
        }

        return clashes
    }

    private func severity(forGapHours gapHours: Double) -> ClashSeverity {
        let absoluteGap = abs(gapHours)

        if absoluteGap < 12 {
            return .sameDay
        } else if absoluteGap < 24 {
            return .dayBefore
        } else {
            return .advanceWarning
        }
    }
}
