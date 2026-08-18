import SwiftUI

struct MessageBubble: View {
    let message: CodexMessage

    private var isUser: Bool { message.role == .user }

    var body: some View {
        VStack(alignment: isUser ? .trailing : .leading, spacing: 4) {
            Text(message.role.displayName)
                .font(.caption2)
                .foregroundStyle(.secondary)

            Text(message.content)
                .font(.footnote)
                .padding(8)
                .frame(maxWidth: .infinity, alignment: isUser ? .trailing : .leading)
                .background(isUser ? Color.accentColor.opacity(0.35) : Color.secondary.opacity(0.18))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        .frame(maxWidth: .infinity, alignment: isUser ? .trailing : .leading)
    }
}
