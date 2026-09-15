import Foundation

protocol DeadlineRepository {
    func fetchDeadlines() -> [AcademicDeadline]
}

struct InMemoryDeadlineRepository: DeadlineRepository {
    func fetchDeadlines() -> [AcademicDeadline] {
        SampleData.deadlines()
    }
}
