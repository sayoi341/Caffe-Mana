import SwiftUI
import ComposableArchitecture

struct SideScrollCenter<T: View>: View {
    private let isShowIndex: Bool
    private let content: () -> T

    init(isShowIndex: Bool, @ViewBuilder content: @escaping () -> T) {
        self.isShowIndex = isShowIndex
        self.content = content
    }
    var body: some View {
        TabView {
            content()
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: isShowIndex ? .always: .never))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct SideScrollCenter_Previews: PreviewProvider {
    static var previews: some View{
        Layout(
            store: Store(
                initialState: Root.State(),
                reducer: Root()
            ),
            home: {
                SideScrollCenter(isShowIndex: true) {
                    ForEach(0..<3) { index in
                        if index == 0 {
                            Color.red
                        } else if index == 1{
                            Color.blue
                        } else {
                            Color.green
                        }
                    }
                }
                
            },
            add: {
                SideScrollCenter(isShowIndex: false) {
                    ForEach(0..<3) { index in
                        Text("\(index)")
                    }
                }
            },
            setting: {
                Text("setting")
            }
        )
    }
}
