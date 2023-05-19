import SwiftUI
import RealmSwift
import SpriteKit
import ComposableArchitecture

class GameScene: SKScene {
    override func didMove(to view: SKView) {
        self.backgroundColor = .clear
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            makeDrink(at: location)
            
        }
    }
    
    func makeDrink(at position: CGPoint) {
        let drink = SKSpriteNode(imageNamed: "monsterEnergy")
        drink.physicsBody = SKPhysicsBody(rectangleOf: drink.size)
        drink.position = position
        addChild(drink)
    }
}



struct Home: View {
    let year: Int
    @ObservedRealmObject var monthLog: MonthLogRecord
    
    var scene: SKScene {
        let scene = GameScene()
        scene.scaleMode = .resizeFill
        return scene
    }
    
    var body: some View {
        SpriteView(scene: self.scene, options: [.allowsTransparency])
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
