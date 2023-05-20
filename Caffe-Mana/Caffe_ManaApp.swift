import SwiftUI
import ComposableArchitecture
import RealmSwift

@main
struct Caffe_ManaApp: SwiftUI.App {
    var body: some Scene {
        @ObservedResults(YearLogRecord.self) var yearLogs
                
        WindowGroup {
            Layout(
                store: Store(
                    initialState: Root.State(),
                    reducer: Root()
                ),
                home: {
                    SideScrollCenter(isShowIndex: true) {
                        ForEach(yearLogs, id:\._id, content: { yearLog in
                            ForEach(yearLog.monthLogs, id:\._id, content: { monthLog in
                                Home(
                                    year: yearLog.year,
                                    month: monthLog.month,
                                    drinks: Array(monthLog.dayLogs.flatMap { $0.drinkLogs })
                                )
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
