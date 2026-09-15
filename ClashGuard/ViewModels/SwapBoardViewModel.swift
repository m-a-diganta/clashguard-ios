import Foundation

class SwapBoardViewModel: ObservableObject {
    @Published var flaggedClashes: [ClashRecord] = []
    @Published var errorMessage: String?

    private let flagShiftForSwapUseCase = FlagShiftForSwapUseCase()

    func flag(clash: ClashRecord) {
        guard !flaggedClashes.contains(where: { $0.id == clash.id }) else {
            return
        }

        do {
            let flagged = try flagShiftForSwapUseCase.execute(clash: clash)
            flaggedClashes.append(flagged)
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
