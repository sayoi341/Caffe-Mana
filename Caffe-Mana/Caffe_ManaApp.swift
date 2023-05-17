import SwiftUI
import ComposableArchitecture

@main
struct Caffe_ManaApp: App {
    var body: some Scene {
        WindowGroup {
            Layout(
                store: Store(
                    initialState: Root.State(),
                    reducer: Root()
                )
            )
        }
    }
}
