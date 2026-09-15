import XCTest
@testable import ClashGuard

final class DetectClashUseCaseTests: XCTestCase {
    let useCase = DetectClashUseCase()
    let workerID = WorkerIdentifier(rawValue: "worker-1")

    func test_detectClash_flags_whenShiftEndsSameDayAsDeadline() throws {
        let now = Date()
        let shift = RosterShift(
            id: UUID(),
            workerID: workerID,
            workplace: "Woolworths",
            roleTitle: "Checkout",
            startTime: now,
            endTime: now.addingTimeInterval(3600 * 4),
            publishedAt: now
        )
        let deadline = AcademicDeadline(
            id: UUID(),
            workerID: workerID,
            title: "Assignment 2 due",
            type: .assessment,
            dueAt: now.addingTimeInterval(3600 * 6),
            weightPercent: 30
        )

        let result = try useCase.execute(shifts: [shift], deadlines: [deadline])

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.severity, .sameDay)
    }

    func test_detectClash_returnsDayBefore_whenGapIsBetween12And24Hours() throws {
        let now = Date()
        let shift = RosterShift(
            id: UUID(),
            workerID: workerID,
            workplace: "Woolworths",
            roleTitle: "Checkout",
            startTime: now,
            endTime: now.addingTimeInterval(3600),
            publishedAt: now
        )
        let deadline = AcademicDeadline(
            id: UUID(),
            workerID: workerID,
            title: "Quiz 3",
            type: .quiz,
            dueAt: now.addingTimeInterval(3600 * 18),
            weightPercent: nil
        )

        let result = try useCase.execute(shifts: [shift], deadlines: [deadline])

        XCTAssertEqual(result.first?.severity, .dayBefore)
    }

    func test_detectClash_returnsNoClashes_whenGapExceeds24Hours() throws {
        let now = Date()
        let shift = RosterShift(
            id: UUID(),
            workerID: workerID,
            workplace: "Woolworths",
            roleTitle: "Checkout",
            startTime: now,
            endTime: now.addingTimeInterval(3600),
            publishedAt: now
        )
        let deadline = AcademicDeadline(
            id: UUID(),
            workerID: workerID,
            title: "Final Exam",
            type: .exam,
            dueAt: now.addingTimeInterval(3600 * 48),
            weightPercent: nil
        )

        let result = try useCase.execute(shifts: [shift], deadlines: [deadline])

        XCTAssertTrue(result.isEmpty)
    }

    func test_detectClash_fails_whenNoShiftsProvided() {
        let deadline = AcademicDeadline(
            id: UUID(),
            workerID: workerID,
            title: "Assignment 2 due",
            type: .assessment,
            dueAt: Date(),
            weightPercent: 30
        )

        XCTAssertThrowsError(try useCase.execute(shifts: [], deadlines: [deadline]))
    }

    func test_detectClash_fails_whenNoDeadlinesProvided() {
        let shift = RosterShift(
            id: UUID(),
            workerID: workerID,
            workplace: "Woolworths",
            roleTitle: "Checkout",
            startTime: Date(),
            endTime: Date().addingTimeInterval(3600),
            publishedAt: Date()
        )

        XCTAssertThrowsError(try useCase.execute(shifts: [shift], deadlines: []))
    }
}
