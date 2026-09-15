import Foundation

class ClashAlertViewModel: ObservableObject {
    @Published var clashes: [ClashRecord] = []
    @Published var errorMessage: String?

    private let detectClashUseCase = DetectClashUseCase()

    func loadClashes(shifts: [RosterShift], deadlines: [AcademicDeadline]) {
        do {
            clashes = try detectClashUseCase.execute(shifts: shifts, deadlines: deadlines)
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
