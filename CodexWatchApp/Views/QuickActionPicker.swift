import SwiftUI

struct QuickActionPicker: View {
    @Binding var selection: QuickAction

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(QuickAction.allCases) { action in
                    Button {
                        selection = action
                    } label: {
                        Label(action.title, systemImage: action.symbolName)
                            .font(.caption2.weight(.semibold))
                            .labelStyle(.iconOnly)
                            .frame(width: 36, height: 36)
                            .background(selection == action ? action.tint.opacity(0.35) : Color.secondary.opacity(0.16))
                            .clipShape(Circle())
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel(action.title)
                }
            }
            .padding(.vertical, 2)
        }
    }
}
