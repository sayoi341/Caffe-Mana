import SwiftUI
import ComposableArchitecture
import RealmSwift

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
        @ObservedResults(YearLogRecord.self) var yearLogs
        let db = db()
        Layout(
            store: Store(
                initialState: Root.State(),
                reducer: Root()
            ),
            home: {
                SideScrollCenter(isShowIndex: true) {
                    ForEach(yearLogs, id:\._id, content: { yearLog in
                        ForEach(yearLog.monthLogs, id:\._id, content: { monthLog in
                            Home(year: yearLog.year ,monthLog: monthLog)
                            
                        })
                    })
                }
            },
            add: {
                    Add()
                 
            },
            setting: {
                VStack {
                     Button(action:{
                         db.addDrink(drinkId: "unchi")
                     }) {
                         Text("add")
                     }

                     Button(action:{
                         db.deleteDB()
                     }) {
                         Text("delete")
                     }
                     Button(action: {
                         db.printRealmFilePath()
                     }) {
                         Text("print path")
                     }
                 }
            }
            
        )
    }
}

