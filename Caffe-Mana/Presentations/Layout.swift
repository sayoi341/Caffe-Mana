import SwiftUI
import ComposableArchitecture
import UIKit

struct Layout<Home: View, Add: View, Setting: View>: View {
    
    let store: StoreOf<Root>
    let home:Home
    let add: Add
    let setting: Setting
    
    init(
        store: StoreOf<Root>,
        @ViewBuilder home: () -> Home,
        @ViewBuilder add: () -> Add,
        @ViewBuilder setting: () -> Setting
    ) {
        self.store = store
        self.home = home()
        self.add = add()
        self.setting = setting()
    }
    
    var body: some View {
        WithViewStore(self.store) {viewStore in
            
            NavigationView {
                ZStack {
                    Color("background")
                        .edgesIgnoringSafeArea(.top)
                    HStack{
                        if viewStore.view == StateType.home {
                            home
                        } else if viewStore.view == StateType.add {
                            add
                        } else if viewStore.view == StateType.setting {
                            setting
                        }
                    }
                }
                .navigationBarHidden(true)
                .toolbar {
                    ToolbarItem(placement: .bottomBar){
                        HStack(spacing: 50) {
                            Button(action: {
                                viewStore.send(.viewAdd)
                            }, label: {
                                VStack(spacing: 2){
                                    SVGImage(name: "button-add").frame(width: 30, height: 30)
                                    Rectangle()
                                    .fill(viewStore.view == StateType.add ? Color.black : Color.white)
                                        .frame(width: 30, height: 2)
                                        .cornerRadius(1)
                                }
                            })

                            Button(action: {
                                viewStore.send(.viewHome)
                            }, label: {
                                VStack(spacing: 2){
                                    SVGImage(name: "button-home").frame(width: 30, height: 30)
                                    Rectangle()
                                    .fill(viewStore.view == StateType.home ? Color.black : Color.white)
                                        .frame(width: 30, height: 2)
                                        .cornerRadius(1)
                                }
                            })
                            Button(action: {
                                
                                viewStore.send(.viewHome)
                            }, label: {
                                SVGImage(name: "button-docs").frame(width: 30, height: 30)
                            })
                        }
                    }
                }
            }
            .navigationViewStyle(.stack)
        }
    }
}

struct Layout_Previews: PreviewProvider {
    static var previews: some View {
        Layout(
            store: Store(
                initialState: Root.State(),
                reducer: Root()
            ),
            home: {
                Text("home")
            },
            add: {
                Text("add")
            },
            setting: {
                Text("setting")
            }
        )
    }
}

