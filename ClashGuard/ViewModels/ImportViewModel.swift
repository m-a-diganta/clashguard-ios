import Foundation

class ImportViewModel: ObservableObject {
    @Published var didImport = false
    @Published var shifts: [RosterShift] = []
    @Published var deadlines: [AcademicDeadline] = []

    private let rosterRepository: RosterRepository
    private let deadlineRepository: DeadlineRepository

    init(
        rosterRepository: RosterRepository = InMemoryRosterRepository(),
        deadlineRepository: DeadlineRepository = InMemoryDeadlineRepository()
    ) {
        self.rosterRepository = rosterRepository
        self.deadlineRepository = deadlineRepository
    }

    func importRoster() {
        shifts = rosterRepository.fetchShifts()
        deadlines = deadlineRepository.fetchDeadlines()
        didImport = true
    }
}
