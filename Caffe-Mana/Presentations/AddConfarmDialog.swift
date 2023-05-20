import SwiftUI
import ComposableArchitecture

struct AddConfarmDialog: View {
    let store: StoreOf<AddConfarm>
    
    var body: some View{
        WithViewStore(self.store) { viewStore in
            if  viewStore.isConfarmOpen {
                ZStack{
                    Color(red: 0.37, green: 0.37, blue: 0.37, opacity: 0.7)
                        .edgesIgnoringSafeArea(.top)
                    Rectangle()
                        .fill(Color(red: 1.0, green: 0.785, blue: 0.34))
                        .frame(width: 320, height: 420)
                        .cornerRadius(20)
                    Rectangle()
                        .fill(Color("background"))
                        .frame(width: 300, height: 400)
                        .cornerRadius(20)
                    VStack(spacing:0){
                        VStack{
                            Spacer()
                            SVGImage(name: viewStore.addData.fileName)
                                .frame(width: 60, height: 150)
                            Spacer()
                            Text(viewStore.addData.name)
                            Spacer()
                            Text("このドリンクを追加します。\nよろしいですか？")
                                .frame(width: 300)
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                        .frame(width: 300, height: 340)
                        HStack(spacing:0){
                            Button(action:{
                                viewStore.send(.closeConfarm)
                            }){
                                ZStack{
                                    Color(red: 1.0, green: 0.36, blue: 0.56)
                                    Text("Cansel")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color.white)
                                    
                                }.frame(width: 150, height: 60)
                            }
                            
                            
                            
                            Button(action:{
                                viewStore.send(.closeConfarm)
                                viewStore.send(.setIsDropShow(status: true))
                                viewStore.send(.startDrop)
                            }){
                                ZStack{
                                    Color(red: 0.53, green: 0.91, blue: 0.39)
                                    Text("OK")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color.white)
                                }
                            }
                            .frame(width: 150, height: 60)
                        }
                        .frame(width: 300, height: 60)
                    }
                    .frame(width: 300, height: 400)
                    .cornerRadius(15)
                    
                    
                }
            }
        }
    }
}

struct AddConfarmDialog_Previews: PreviewProvider{
    static var previews: some View {
        
        Layout(
            store: Store(
                initialState: Root.State(),
                reducer: Root()
            ),
            home: {
                AddConfarmDialog(
                    store: Store(
                        initialState: AddConfarm.State(),
                        reducer: AddConfarm()
                    )
                )
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
