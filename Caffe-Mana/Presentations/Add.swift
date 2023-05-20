import SwiftUI
import ComposableArchitecture

struct Add: View {
    let store = Store(initialState: AddConfarm.State(),reducer: AddConfarm())
    let keys = drinkData.keys
    let drinkCount = drinkData.count
    
    var body: some View{
        ZStack{
            ZStack{
                SideScrollCenter(isShowIndex: true) {
                    ForEach(0..<addDrinkData.count, id: \.self) { data in
                        VendingMachine(
                            topData: addDrinkData[data][0], bottomData: addDrinkData[data][1], store: store
                        )
                    }
                }
                AddConfarmDialog(
                    store: store
                )
            }
        }
    }
}

struct Add_Previews: PreviewProvider {
    static var previews: some View {
        Layout(
            store: Store(
                initialState: Root.State(),
                reducer: Root()
            ),
            home: {
                Add()
            },
            add: {
                Add()
            },
            setting: {
                Text("setting")
            }
        )
    }
}

