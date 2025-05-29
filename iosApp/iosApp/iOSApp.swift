import SwiftUI
import shared


@main
struct iOSApp: App {
    init() {
        KoinInitializer().doInitKoin()
    }
    
	var body: some Scene {
		WindowGroup {
            
            MainUIView()
		}
	}
}
