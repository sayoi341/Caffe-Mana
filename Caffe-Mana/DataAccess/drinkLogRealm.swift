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
    @Persisted var dayLogs: RealmSwift.List<DayLogRecord>
    
    
    convenience init(month: Int, dayLogs: List<DayLogRecord>) {
        self.init()
        self.month = month
        self.dayLogs = .init()
        self.dayLogs = dayLogs
    }
}

class DayLogRecord: Object, Identifiable {
    @Persisted(primaryKey: true) var _id = UUID().uuidString
    
    @Persisted var day: Int
    @Persisted var drinkLogs: RealmSwift.List<DrinkLogRecord>
    
    convenience init(day: Int, drinkLogs: List<DrinkLogRecord>) {
        self.init()
        self.day = day
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
        let day = Calendar.current.component(.day, from: Date())
        
        
        let drinkLog = DrinkLogRecord(drinkId: drinkId, date: Date())
        
        try! realm.write {
            
            //年テーブル
            let yearLogFirst = data.filter { yearLog in
                yearLog.year == year
            }.first
            if yearLogFirst != nil {
                
                //月テーブル
                let monthLogFirst = yearLogFirst?.monthLogs.filter { monthLog in
                    monthLog.month == month
                }.first
                if monthLogFirst != nil {
                    
                    //日テーブル
                    let dayLogFirst = monthLogFirst?.dayLogs.filter { dayLog in
                        dayLog.day == day
                    }.first
                    if dayLogFirst != nil {
                        dayLogFirst?.drinkLogs.append(drinkLog)
                    } else {
                        let dayLog = DayLogRecord(day: day, drinkLogs: List<DrinkLogRecord>())
                        dayLog.drinkLogs.append(drinkLog)
                        monthLogFirst?.dayLogs.append(dayLog)
                    }
                    
                } else {
                    let dayLog = DayLogRecord(day: day, drinkLogs: List<DrinkLogRecord>())
                    dayLog.drinkLogs.append(drinkLog)
                    let monthLog = MonthLogRecord(month: month, dayLogs: List<DayLogRecord>())
                    monthLog.dayLogs.append(dayLog)
                    yearLogFirst?.monthLogs.append(monthLog)
                }
                
            } else {
                let dayLog = DayLogRecord(day: day, drinkLogs: List<DrinkLogRecord>())
                dayLog.drinkLogs.append(drinkLog)
                let monthLog = MonthLogRecord(month: month, dayLogs: List<DayLogRecord>())
                monthLog.dayLogs.append(dayLog)
                let yearLog = YearLogRecord(year: year, monthLogs: List<MonthLogRecord>())
                yearLog.monthLogs.append(monthLog)
                realm.add(yearLog)
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
