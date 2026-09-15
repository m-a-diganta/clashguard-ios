import XCTest
@testable import ClashGuard

final class ImportRosterUseCaseTests: XCTestCase {
    let useCase = ImportRosterUseCase()
    let workerID = WorkerIdentifier(rawValue: "worker-1")

    func test_importRoster_succeeds_withValidShift() throws {
        let shift = RosterShift(
            id: UUID(),
            workerID: workerID,
            workplace: "Woolworths",
            roleTitle: "Checkout",
            startTime: Date(),
            endTime: Date().addingTimeInterval(3600),
            publishedAt: Date()
        )

        let result = try useCase.execute(rawShifts: [shift])

        XCTAssertEqual(result.count, 1)
    }

    func test_importRoster_fails_whenNoShiftsProvided() {
        XCTAssertThrowsError(try useCase.execute(rawShifts: [])) { error in
            XCTAssertEqual(error as? ImportRosterError, .emptyInput)
        }
    }

    func test_importRoster_fails_whenShiftEndsBeforeItStarts() {
        let shift = RosterShift(
            id: UUID(),
            workerID: workerID,
            workplace: "Woolworths",
            roleTitle: "Checkout",
            startTime: Date(),
            endTime: Date().addingTimeInterval(-3600),
            publishedAt: Date()
        )

        XCTAssertThrowsError(try useCase.execute(rawShifts: [shift]))
    }
}

extension ImportRosterError: Equatable {
    public static func == (lhs: ImportRosterError, rhs: ImportRosterError) -> Bool {
        switch (lhs, rhs) {
        case (.emptyInput, .emptyInput):
            return true
        case (.invalidDateRange(let a), .invalidDateRange(let b)):
            return a == b
        default:
            return false
        }
    }
}
