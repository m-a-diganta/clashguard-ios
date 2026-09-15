import Foundation

enum SampleData {
    static func shifts() -> [RosterShift] {
        let workerID = WorkerIdentifier(rawValue: "worker-1")
        return [
            RosterShift(
                id: UUID(),
                workerID: workerID,
                workplace: "Woolworths",
                roleTitle: "Checkout",
                startTime: Date().addingTimeInterval(60 * 60 * 5),
                endTime: Date().addingTimeInterval(60 * 60 * 9),
                publishedAt: Date()
            )
        ]
    }

    static func deadlines() -> [AcademicDeadline] {
        let workerID = WorkerIdentifier(rawValue: "worker-1")
        return [
            AcademicDeadline(
                id: UUID(),
                workerID: workerID,
                title: "Assignment 2 due",
                type: .assessment,
                dueAt: Date().addingTimeInterval(60 * 60 * 10),
                weightPercent: 30
            )
        ]
    }
}
