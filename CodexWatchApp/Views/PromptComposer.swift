import SwiftUI

struct PromptComposer: View {
    @EnvironmentObject private var session: CodexSession
    @FocusState private var promptFocused: Bool

    var body: some View {
        VStack(spacing: 8) {
            TextField("Ask Codex", text: $session.prompt, axis: .vertical)
                .focused($promptFocused)
                .lineLimit(1...4)
                .submitLabel(.send)
                .onSubmit(submit)

            Button(action: submit) {
                Label(session.isThinking ? "Thinking" : "Send", systemImage: session.isThinking ? "hourglass" : "paperplane.fill")
                    .frame(maxWidth: .infinity)
            }
            .disabled(session.prompt.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || session.isThinking)
        }
    }

    private func submit() {
        Task {
            await session.submitPrompt()
            promptFocused = false
        }
    }
}
