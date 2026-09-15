import Foundation

enum ImportRosterError: LocalizedError {
    case emptyInput
    case invalidDateRange(shiftDescription: String)

    var errorDescription: String? {
        switch self {
        case .emptyInput:
            return "No roster data was provided. Add a shift before importing."
        case .invalidDateRange(let shiftDescription):
            return "The shift \(shiftDescription) ends before it starts. Check the times and try again."
        }
    }
}

/// Checks raw shift entries and turns them into usable RosterShift records.
struct ImportRosterUseCase {
    func execute(rawShifts: [RosterShift]) throws -> [RosterShift] {
        guard !rawShifts.isEmpty else {
            throw ImportRosterError.emptyInput
        }

        for shift in rawShifts {
            if shift.endTime <= shift.startTime {
                throw ImportRosterError.invalidDateRange(shiftDescription: shift.roleTitle)
            }
        }

        return rawShifts
    }
}
