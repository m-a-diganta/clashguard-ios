import Foundation

enum SampleData {
    static func shifts() -> [RosterShift] {
        let workerID = WorkerIdentifier(rawValue: "worker-1")
        let now = Date()

        return [
            RosterShift(
                id: UUID(),
                workerID: workerID,
                workplace: "Woolworths",
                roleTitle: "Checkout",
                startTime: now.addingTimeInterval(3600 * 2),
                endTime: now.addingTimeInterval(3600 * 6),
                publishedAt: now
            ),
            RosterShift(
                id: UUID(),
                workerID: workerID,
                workplace: "Woolworths",
                roleTitle: "Trolley collection",
                startTime: now.addingTimeInterval(3600 * 30),
                endTime: now.addingTimeInterval(3600 * 34),
                publishedAt: now
            ),
            RosterShift(
                id: UUID(),
                workerID: workerID,
                workplace: "Woolworths",
                roleTitle: "Checkout",
                startTime: now.addingTimeInterval(3600 * 50),
                endTime: now.addingTimeInterval(3600 * 54),
                publishedAt: now
            ),
            RosterShift(
                id: UUID(),
                workerID: workerID,
                workplace: "Woolworths",
                roleTitle: "Online orders picking",
                startTime: now.addingTimeInterval(3600 * 100),
                endTime: now.addingTimeInterval(3600 * 104),
                publishedAt: now
            )
        ]
    }

    static func deadlines() -> [AcademicDeadline] {
        let workerID = WorkerIdentifier(rawValue: "worker-1")
        let now = Date()

        return [
            AcademicDeadline(
                id: UUID(),
                workerID: workerID,
                title: "Assignment 2 due",
                type: .assessment,
                dueAt: now.addingTimeInterval(3600 * 7),
                weightPercent: 30
            ),
            AcademicDeadline(
                id: UUID(),
                workerID: workerID,
                title: "Data Analytics Lecture",
                type: .classSession,
                dueAt: now.addingTimeInterval(3600 * 26),
                weightPercent: nil
            ),
            AcademicDeadline(
                id: UUID(),
                workerID: workerID,
                title: "Quiz 3",
                type: .quiz,
                dueAt: now.addingTimeInterval(3600 * 40),
                weightPercent: 10
            ),
            AcademicDeadline(
                id: UUID(),
                workerID: workerID,
                title: "Data Analytics Exam",
                type: .exam,
                dueAt: now.addingTimeInterval(3600 * 70),
                weightPercent: nil
            ),
            AcademicDeadline(
                id: UUID(),
                workerID: workerID,
                title: "Assignment 3 due",
                type: .assessment,
                dueAt: now.addingTimeInterval(3600 * 200),
                weightPercent: 25
            )
        ]
    }
}
