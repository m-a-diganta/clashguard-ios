import Foundation

enum SwapRequestError: LocalizedError {
    case alreadyResolved

    var errorDescription: String? {
        switch self {
        case .alreadyResolved:
            return "This clash is already resolved. There is nothing to swap."
        }
    }
}

/// Sends a clashing shift to the swap board so another worker can take it.
struct FlagShiftForSwapUseCase {
    func execute(clash: ClashRecord) throws -> ClashRecord {
        guard !clash.isResolved else {
            throw SwapRequestError.alreadyResolved
        }

        return clash
    }
}
