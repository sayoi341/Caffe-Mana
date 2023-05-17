import SwiftUI
import ComposableArchitecture
import UIKit

struct Layout: View {
    
    let store: StoreOf<Root>
    
    var body: some View {
        WithViewStore(self.store) {viewStore in
            
            NavigationView {
                ZStack {
                    Color("background")
                        .edgesIgnoringSafeArea(.top)
                    HStack{
                        if viewStore.view == StateType.home {
                            Text("home")
                        } else if viewStore.view == StateType.add {
                            Text("add")
                        } else if viewStore.view == StateType.setting {
                            Text("setting")
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
                                SVGImage(name: "button-add").frame(width: 30, height: 30)
                            })
                            Button(action: {
                                viewStore.send(.viewHome)
                            }, label: {
                                SVGImage(name: "button-home").frame(width: 30, height: 30)
                            })
                            Button(action: {
                                
                            }, label: {
                                SVGImage(name: "button-docs").frame(width: 30, height: 30)
                            })
                        }
                    }
                }
            }
        }
    }
}

struct Layout_Previews: PreviewProvider {
    static var previews: some View {
        Layout(
            store: Store(
                initialState: Root.State(),
                reducer: Root()
            )
        )
    }
}

