import SwiftUI

struct DashboardView: View {
    @EnvironmentObject private var session: CodexSession

    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                List {
                    Section {
                        QuickActionPicker(selection: $session.selectedAction)
                    } header: {
                        Text("Codex")
                    }

                    Section("Conversation") {
                        ForEach(session.messages) { message in
                            MessageBubble(message: message)
                                .id(message.id)
                                .listRowBackground(Color.clear)
                        }

                        if session.isThinking {
                            ThinkingRow()
                                .listRowBackground(Color.clear)
                        }
                    }

                    Section {
                        PromptComposer()
                    }
                }
                .navigationTitle("Codex")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(role: .destructive) {
                            session.clearConversation()
                        } label: {
                            Image(systemName: "trash")
                        }
                        .accessibilityLabel("Clear conversation")
                    }
                }
                .onChange(of: session.messages) { _, messages in
                    guard let lastMessage = messages.last else { return }
                    withAnimation {
                        proxy.scrollTo(lastMessage.id, anchor: .bottom)
                    }
                }
            }
        }
    }
}

#Preview {
    DashboardView()
        .environmentObject(CodexSession())
}
