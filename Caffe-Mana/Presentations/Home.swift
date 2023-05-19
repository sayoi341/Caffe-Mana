import SwiftUI
import RealmSwift

struct Home: View {
    let year: Int
    @ObservedRealmObject var monthLog: MonthLogRecord
    
    
    var body: some View {
        VStack{
            Text(String(year))
            Text(String(monthLog.month))
            
            ForEach(monthLog.drinkLogs) { drinkLog in
                HStack{
                    Text(drinkLog.drinkId)
                    Text(drinkLog._id)
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        let monthLogs = MonthLogRecord(month: 1, DrinkLogs: List<DrinkLog>())
        
        Home(year: 1, monthLog: monthLogs)
    }
}
