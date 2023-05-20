import SwiftUI
import ComposableArchitecture
import RealmSwift

@main
struct Caffe_ManaApp: SwiftUI.App {
    var body: some Scene {
        let store = Store(
            initialState: Root.State(),
            reducer: Root()
        )
        @ObservedResults(YearLogRecord.self) var yearLogs
                
        WindowGroup {
            Layout(
                store: store,
                home: {
                    SideScrollCenter(isShowIndex: true) {
                        ForEach(yearLogs, id:\._id, content: { yearLog in
                            ForEach(yearLog.monthLogs, id:\._id, content: { monthLog in
                                ZStack{
                                    Home(
                                        year: yearLog.year,
                                        month: monthLog.month,
                                        drinks: Array(monthLog.dayLogs.flatMap { $0.drinkLogs })
                                    )
                                    Receipt(
                                        store: store,
                                        year: yearLog.year,
                                        month: monthLog.month,
                                        days: monthLog.dayLogs
                                        
                                    )
                                }
                            })
                        })
                    }
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
}
