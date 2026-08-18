import Foundation

enum CodexRole: String, Codable, CaseIterable, Identifiable {
    case user
    case assistant
    case system

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .user: return "You"
        case .assistant: return "Codex"
        case .system: return "System"
        }
    }
}

struct CodexMessage: Identifiable, Codable, Equatable {
    let id: UUID
    let role: CodexRole
    var content: String
    let createdAt: Date

    init(id: UUID = UUID(), role: CodexRole, content: String, createdAt: Date = .now) {
        self.id = id
        self.role = role
        self.content = content
        self.createdAt = createdAt
    }
}
