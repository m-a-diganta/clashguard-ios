import Foundation

/// The kind of academic event a deadline represents.
enum AcademicEventType: String, Codable {
    case assessment
    case exam
    case quiz
    case classSession
}

/// One academic commitment, an assessment, exam, or class.
/// Business rule: a deadline is high stakes if it is an exam, or an
/// assessment worth 20% or more.
struct AcademicDeadline: Identifiable, Codable, Hashable {
    let id: UUID
    let workerID: WorkerIdentifier
    let title: String
    let type: AcademicEventType
    let dueAt: Date
    let weightPercent: Double?

    var isHighStakes: Bool {
        switch type {
        case .exam:
            return true
        case .assessment:
            return (weightPercent ?? 0) >= 20
        case .quiz, .classSession:
            return false
        }
    }
}
