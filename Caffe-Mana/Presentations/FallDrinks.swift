import SpriteKit
import RealmSwift

class GameScene: SKScene {
    
    open var drinks: [DrinkLogRecord]?
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .clear
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        var position = 200.0
        if drinks != nil {
            for drink in drinks! {
                let thisDrink = drinkData[drink.drinkId]
                if thisDrink != nil {
                    position += 20.0
                    makeDrink(at: CGPoint(x: 220, y: position), drinkName: thisDrink!.fileName)
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

