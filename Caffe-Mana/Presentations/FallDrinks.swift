import SpriteKit
import RealmSwift

class GameScene: SKScene {
    
    open var drinks: RealmSwift.List<DrinkLogRecord>?
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .clear
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        print("make scene")
        
        if drinks != nil {
            for drink in drinks! {
                let thisDrink = drinkData[drink.drinkId]
                var position = 500.0
                if thisDrink != nil {
                    makeDrink(at: CGPoint(x: 220, y: position), drinkName: thisDrink!.fileName)
                    position += 100.0
                }
            }
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

