import Foundation

/// A worker's unique ID, kept as its own type instead of a raw String.
struct WorkerIdentifier: Hashable, Codable {
    let rawValue: String
}

/// One rostered shift from an employer.
/// Business rule: a shift is short notice if it was published less than
/// 72 hours before it starts.
struct RosterShift: Identifiable, Codable, Hashable {
    let id: UUID
    let workerID: WorkerIdentifier
    let workplace: String
    let roleTitle: String
    let startTime: Date
    let endTime: Date
    let publishedAt: Date

    var durationHours: Double {
        endTime.timeIntervalSince(startTime) / 3600
    }

    var isShortNoticeShift: Bool {
        let noticeHours = startTime.timeIntervalSince(publishedAt) / 3600
        return noticeHours < 72
    }
}
