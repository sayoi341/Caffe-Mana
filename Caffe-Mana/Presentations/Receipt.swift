import SwiftUI
import ComposableArchitecture
import RealmSwift

struct Receipt: View {
    let store: StoreOf<Root>
    
    let year: Int
    let month: Int
    let days: RealmSwift.List<DayLogRecord>
    
    let now : Date = Date()
    let dateFormatter = DateFormatter()
    let dateFormatter2 = DateFormatter()
    
    var total:Int=0
    
    init(store: StoreOf<Root>, year: Int, month: Int, days: RealmSwift.List<DayLogRecord>) {
        self.year = year
        self.month = month
        self.days = days
        self.store = store
        
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yMMMdHms", options: 0, locale: Locale(identifier: "ja_JP"))
        dateFormatter2.dateFormat = DateFormatter.dateFormat(fromTemplate: "HHmm", options: 0, locale: Locale(identifier: "ja_JP"))
        total = days.reduce(0, {re, day in
            day.drinkLogs.reduce(0,{rre, log in
                if let dd = drinkData[log.drinkId]{
                    return rre + dd.price
                } else {
                    return rre
                }
            })
            
        })
    }
    
    var body: some View{
        WithViewStore(self.store) {viewStore in
            if viewStore.isReceiptOpen {
                ZStack{
                    Color(red: 0.37, green: 0.37, blue: 0.37, opacity: 0.7)
                    GeometryReader{geoBackground in
                        ScrollView{
                            ZStack{
                                Rectangle()
                                    .fill(Color(red: 1.0, green: 0.937, blue: 0.85))
                                VStack(alignment: .center,spacing: 15){
                                    Rectangle()
                                        .fill(Color(red: 1.0, green: 0.937, blue: 0.85))
                                        .frame(height: geoBackground.size.height*0.15)
                                    Rectangle()
                                        .fill(Color.black)
                                        .frame(width: geoBackground.size.width*0.8, height: 3)
                                    
                                    Text("Caffe Mana")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                    
                                    Rectangle()
                                        .fill(Color.black)
                                        .frame(width: geoBackground.size.width*0.8, height: 3)
                                    HStack(alignment: .bottom, spacing: 0) {
                                        Text(numToMonth(month:month))
                                            .font(.title)
                                            .fontWeight(.bold)
                                        Text(".\(year)".replacingOccurrences(of: ",", with: ""))
                                    }
                                    
                                    HStack{
                                        Text("Date:")
                                        Spacer()
                                        Text(dateFormatter.string(from: now))
                                    }
                                    .frame(width: geoBackground.size.width*0.7)
                                    
                                    Rectangle()
                                        .fill(Color.black)
                                        .frame(width: geoBackground.size.width*0.75, height: 1)
                                    ForEach(days){day in
                                        VStack{
                                            HStack{
                                                Text("Day:")
                                                Spacer()
                                                Text("\(day.day)")
                                            }
                                            ForEach(day.drinkLogs){log in
                                                let d = drinkData[log.drinkId]
                                                if let drink = d {
                                                    HStack{
                                                        Text("\(dateFormatter2.string(from: log.date))")
                                                            .frame(width: 50)
                                                            .font(.subheadline)
                                                        Text(drink.name)
                                                            .font(.subheadline)
                                                        Spacer()
                                                        Text("¥ \(drink.price)")
                                                            .font(.subheadline)
                                                    }
                                                }
                                                
                                            }
                                        }.frame(width: geoBackground.size.width*0.7)
                                    }
                                    
                                    Rectangle()
                                        .fill(Color.black)
                                        .frame(width: geoBackground.size.width*0.75, height: 1)
                                    VStack(spacing:0){
                                        
                                        HStack{
                                            Text("Total:").font(.headline)
                                            Spacer()
                                            Text("¥ \(total)").font(.headline)
                                        }
                                        .frame(width: geoBackground.size.width*0.7)
                                        Rectangle()
                                            .fill(Color(red: 1.0, green: 0.937, blue: 0.85))
                                            .frame(height: geoBackground.size.height*0.02)
                                    }
                                }
                                
                            }
                        }
                    }
                    
                }
                .edgesIgnoringSafeArea(.top)
            }
        }
    }
}


struct Receipt_Previews : PreviewProvider{
    static var previews: some View{
        let store = Store(
            initialState: Root.State(),
            reducer: Root()
        )
        @ObservedResults(YearLogRecord.self) var yearLogs
        
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
