import SwiftUI
import RealmSwift
import SpriteKit
import ComposableArchitecture

struct Home: View {
    let year: Int
    @ObservedRealmObject var monthLog: MonthLogRecord
    
    var scene: SKScene {
        let scene = GameScene()
        scene.scaleMode = .resizeFill
        scene.drinks = monthLog.drinkLogs
        return scene
    }
    
    var body: some View {
        ZStack {
            HStack {
                Text(String(year))
                Text(String(monthLog.month))
                SVGImage(name: "scale")
                    .frame(width: 120)
            }
                
            SpriteView(scene: self.scene, options: [.allowsTransparency])
                
                
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Layout(
            store: Store(
                initialState: Root.State(),
                reducer: Root()
            ),
            home: {
                SideScrollCenter(isShowIndex: true) {
                   // Home(year: 2023, monthLog: MonthLogRecord(month: 4, DrinkLogs: List<DrinkLogRecord>()))
                   // Home(year: 2023, monthLog: MonthLogRecord(month: 5, DrinkLogs: List<DrinkLogRecord>()))
                }
                
            },
            add: {
                SideScrollCenter(isShowIndex: false) {
                    ForEach(0..<3) { index in
                        Text("\(index)")
                    }
                }
            },
            setting: {
                Text("setting")
            }
        )
    }
}
