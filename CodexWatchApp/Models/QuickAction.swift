import SwiftUI

enum QuickAction: String, CaseIterable, Identifiable {
    case explain
    case fix
    case summarize
    case command

    var id: String { rawValue }

    var title: String {
        switch self {
        case .explain: return "Explain"
        case .fix: return "Fix"
        case .summarize: return "Summarize"
        case .command: return "Command"
        }
    }

    var symbolName: String {
        switch self {
        case .explain: return "lightbulb"
        case .fix: return "wrench.and.screwdriver"
        case .summarize: return "text.alignleft"
        case .command: return "terminal"
        }
    }

    var tint: Color {
        switch self {
        case .explain: return .yellow
        case .fix: return .orange
        case .summarize: return .cyan
        case .command: return .green
        }
    }
}
