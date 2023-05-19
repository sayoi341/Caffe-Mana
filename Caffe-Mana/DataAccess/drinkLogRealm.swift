import Foundation
import RealmSwift

class YearLogRecord: Object, Identifiable {
    @Persisted(primaryKey: true) var _id = UUID().uuidString
    
    @Persisted var year: Int
    @Persisted var monthLogs: RealmSwift.List<MonthLogRecord>
    
    convenience init(year: Int, monthLogs: List<MonthLogRecord>) {
        self.init()
        self.year = year
        self.monthLogs = .init()
        self.monthLogs = monthLogs
    }
}

class MonthLogRecord: Object, Identifiable {
    @Persisted(primaryKey: true) var _id = UUID().uuidString
    
    @Persisted var month: Int
    @Persisted var drinkLogs: RealmSwift.List<DrinkLogRecord>
    
    convenience init(month: Int, DrinkLogs: List<DrinkLogRecord>) {
        self.init()
        self.month = month
        self.drinkLogs = .init()
        self.drinkLogs = drinkLogs
    }
}

class DrinkLogRecord: Object, Identifiable {
    @Persisted(primaryKey: true) var _id = UUID().uuidString
    
    @Persisted var drinkId: String
    @Persisted var date: Date
    
    convenience init(drinkId: String, date: Date) {
        self.init()
        self.drinkId = drinkId
        self.date = date
    }
}


class db {
    public var realm: Realm
    public var data: Results<YearLogRecord>
    
    init() {
        self.realm = try! Realm()
        data = self.realm.objects(YearLogRecord.self)
    }
    
    private func setData() {
        data = self.realm.objects(YearLogRecord.self)
    }
    
    // ドリンクの追加用関数
    // DrinkIDを入れるだけで、現在の年、月のDBに追加
    // 固有IDも返してくれる
    public func addDrink(drinkId: String) -> String {
        let year = Calendar.current.component(.year, from: Date())
        let month = Calendar.current.component(.month, from: Date())
        
        let drinkLog = DrinkLogRecord(drinkId: drinkId, date: Date())
        
        try! realm.write {
            let yearLogFirst = data.filter { yearLog in
                yearLog.year == year
            }.first
            
            if yearLogFirst == nil {
                let monthLog = MonthLogRecord(month: month, DrinkLogs: List<DrinkLogRecord>())
                monthLog.drinkLogs.append(drinkLog)
                let yearLog = YearLogRecord(year: year, monthLogs: List<MonthLogRecord>())
                yearLog.monthLogs.append(monthLog)
                realm.add(yearLog)
            } else {
                let monthLogFirst = yearLogFirst?.monthLogs.filter { monthLog in
                    monthLog.month == month
                }.first
                
                if monthLogFirst == nil {
                    let monthLog = MonthLogRecord(month: month, DrinkLogs: List<DrinkLogRecord>())
                    monthLog.drinkLogs.append(drinkLog)
                    yearLogFirst?.monthLogs.append(monthLog)
                } else {
                    monthLogFirst?.drinkLogs.append(drinkLog)
                }
            }
        }
        
        return drinkLog._id
    }
    
    
    public func deleteDB() {
        setData()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    public func printRealmFilePath() {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
}
