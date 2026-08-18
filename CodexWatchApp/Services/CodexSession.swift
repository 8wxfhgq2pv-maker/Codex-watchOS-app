import Foundation
import Combine

@MainActor
final class CodexSession: ObservableObject {
    @Published var prompt: String = ""
    @Published private(set) var messages: [CodexMessage]
    @Published private(set) var isThinking = false
    @Published var selectedAction: QuickAction = .explain

    private let responder: CodexResponding

    init(responder: CodexResponding = LocalCodexResponder()) {
        self.responder = responder
        self.messages = [
            CodexMessage(
                role: .assistant,
                content: "Hi, I’m Codex for Apple Watch. Dictate a task, pick a quick action, and I’ll draft a compact response."
            )
        ]
    }

    func submitPrompt() async {
        let trimmedPrompt = prompt.trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmedPrompt.isEmpty == false, isThinking == false else { return }

        prompt = ""
        let userMessage = CodexMessage(role: .user, content: trimmedPrompt)
        messages.append(userMessage)
        isThinking = true

        do {
            let reply = try await responder.reply(to: trimmedPrompt, action: selectedAction, history: messages)
            messages.append(CodexMessage(role: .assistant, content: reply))
        } catch {
            messages.append(
                CodexMessage(
                    role: .assistant,
                    content: "I couldn’t complete that request on watch right now. Please try again from your wrist or continue on iPhone."
                )
            )
        }

        isThinking = false
    }

    func clearConversation() {
        messages = [
            CodexMessage(role: .assistant, content: "Conversation cleared. What should we build next?")
        ]
    }
}

protocol CodexResponding {
    func reply(to prompt: String, action: QuickAction, history: [CodexMessage]) async throws -> String
}

struct LocalCodexResponder: CodexResponding {
    func reply(to prompt: String, action: QuickAction, history: [CodexMessage]) async throws -> String {
        try await Task.sleep(nanoseconds: 650_000_000)

        switch action {
        case .explain:
            return "Here’s the gist: \(prompt)\n\n• Break the task into a small watch-sized goal.\n• Keep context short.\n• Hand off deeper edits to iPhone or Mac."
        case .fix:
            return "Suggested fix plan for “\(prompt)”:\n\n1. Reproduce the issue.\n2. Check the smallest affected file.\n3. Patch, test, then commit."
        case .summarize:
            return "Summary: \(prompt)\n\nThe key action is to capture intent quickly and preserve enough context for Codex to continue elsewhere."
        case .command:
            return "Command draft:\n\ncodex \"\(prompt)\"\n\nReview before running on a paired device or workstation."
        }
    }
}
