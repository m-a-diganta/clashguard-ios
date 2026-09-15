import XCTest
@testable import ClashGuard

final class FlagShiftForSwapUseCaseTests: XCTestCase {
    let useCase = FlagShiftForSwapUseCase()
    let workerID = WorkerIdentifier(rawValue: "worker-1")

    private func makeClash(isResolved: Bool) -> ClashRecord {
        let shift = RosterShift(
            id: UUID(),
            workerID: workerID,
            workplace: "Woolworths",
            roleTitle: "Checkout",
            startTime: Date(),
            endTime: Date().addingTimeInterval(3600),
            publishedAt: Date()
        )
        let deadline = AcademicDeadline(
            id: UUID(),
            workerID: workerID,
            title: "Assignment 2 due",
            type: .assessment,
            dueAt: Date().addingTimeInterval(3600 * 2),
            weightPercent: 30
        )

        return ClashRecord(
            id: UUID(),
            shift: shift,
            deadline: deadline,
            severity: .sameDay,
            gapHours: 1,
            isResolved: isResolved
        )
    }

    func test_flagForSwap_succeeds_whenClashIsUnresolved() throws {
        let clash = makeClash(isResolved: false)

        let result = try useCase.execute(clash: clash)

        XCTAssertEqual(result.id, clash.id)
    }

    func test_flagForSwap_fails_whenClashIsAlreadyResolved() {
        let clash = makeClash(isResolved: true)

        XCTAssertThrowsError(try useCase.execute(clash: clash))
    }
}
