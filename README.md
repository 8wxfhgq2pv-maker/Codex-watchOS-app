# Codex WatchOS

Codex WatchOS is a SwiftUI prototype that brings a compact Codex-style assistant to Apple Watch. It focuses on quick wrist-first interactions: dictate a request, choose a quick action, and receive a concise response that can later be expanded on iPhone or Mac.

## Features

- Native watchOS SwiftUI app entry point.
- Quick actions for explaining code, fixing bugs, summarizing context, and drafting Codex commands.
- Lightweight local responder that simulates Codex responses while the network/API layer is integrated.
- Conversation reset and watch-sized message bubbles.

## Project layout

- `CodexWatchApp/CodexWatchApp.swift` contains the watchOS app entry point.
- `CodexWatchApp/Services/CodexSession.swift` owns prompt submission, message state, and the replaceable responder abstraction.
- `CodexWatchApp/Views/` contains the Apple Watch UI.

## Next steps

1. Replace `LocalCodexResponder` with an authenticated OpenAI API client or a paired-iPhone relay.
2. Add real app icons to `Assets.xcassets/AppIcon.appiconset`.
3. Configure a development team and bundle identifier in Xcode before installing on hardware.
