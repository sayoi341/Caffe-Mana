import SwiftUI
import RealmSwift
import SpriteKit
import ComposableArchitecture

class GameScene: SKScene {
    
    open var drinks: RealmSwift.List<DrinkLogRecord>?
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .clear
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        for drink in drinks! {
            let drinkName = drinkData.first(where: {String($0.id) == drink.drinkId})?.fileName
            makeDrink(at: CGPoint(x: 220, y: 300), drinkName: drinkName == nil ? "monsterEnergy" : drinkName!)
        }
    }
    
    public func makeDrink(at position:CGPoint, drinkName: String) {
        let drink = SKSpriteNode(imageNamed: drinkName)
        drink.physicsBody = SKPhysicsBody(rectangleOf: drink.size)
        drink.position = position
        drink.zRotation = CGFloat(Float.random(in: 0...2) * Float.pi)
        addChild(drink)
    }
}



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
                    Home(year: 2023, monthLog: MonthLogRecord(month: 4, DrinkLogs: List<DrinkLogRecord>()))
                    Home(year: 2023, monthLog: MonthLogRecord(month: 5, DrinkLogs: List<DrinkLogRecord>()))
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
