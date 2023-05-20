import SwiftUI
import ComposableArchitecture
import RealmSwift

@main
struct Caffe_ManaApp: SwiftUI.App {
    var body: some Scene {
        @ObservedResults(YearLogRecord.self) var yearLogs
        let db = db()
        
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
                                Home(year: yearLog.year ,monthLog: monthLog)
                                
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
