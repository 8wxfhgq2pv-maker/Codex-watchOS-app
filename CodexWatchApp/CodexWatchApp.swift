import SwiftUI

@main
struct CodexWatchApp: App {
    @StateObject private var session = CodexSession()

    var body: some Scene {
        WindowGroup {
            DashboardView()
                .environmentObject(session)
        }
    }
}
