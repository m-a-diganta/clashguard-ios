import Foundation

class ImportViewModel: ObservableObject {
    @Published var didImport = false

    func importRoster() {
        didImport = true
    }
}
