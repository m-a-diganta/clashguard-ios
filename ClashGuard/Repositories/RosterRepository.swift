import Foundation

protocol RosterRepository {
    func fetchShifts() -> [RosterShift]
}

struct InMemoryRosterRepository: RosterRepository {
    func fetchShifts() -> [RosterShift] {
        SampleData.shifts()
    }
}
