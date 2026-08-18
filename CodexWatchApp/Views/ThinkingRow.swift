import SwiftUI

struct ThinkingRow: View {
    var body: some View {
        HStack(spacing: 8) {
            ProgressView()
            Text("Codex is thinking…")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .accessibilityElement(children: .combine)
    }
}
