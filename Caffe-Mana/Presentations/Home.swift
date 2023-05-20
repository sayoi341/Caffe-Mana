import SwiftUI
import RealmSwift
import SpriteKit
import ComposableArchitecture

struct Home: View {
    let year: Int
    let month: Int
    let drinks: [DrinkLogRecord]
    
    var scene: SKScene {
        let scene = GameScene()
        scene.scaleMode = .resizeFill
        scene.drinks = drinks
        return scene
    }
    
    func numToMonth (month: Int) -> String {
        switch (month) {
        case 1:
            return "January"
        case 2:
            return "February"
        case 3:
            return "March"
        case 4:
            return "April"
        case 5:
            return "May"
        case 6:
            return "June"
        case 7:
            return "July"
        case 8:
            return "August"
        case 9:
            return "September"
        case 10:
            return "October"
        case 11:
            return "November"
        case 12:
            return "December"
        default:
            return ""
        }
    }
    
    var body: some View {
        
        ZStack {
            HStack() {
                VStack(alignment: .trailing) {
                    Text("400mg")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("Caffe Mana")
                        .font(.caption)
                        .foregroundColor(.gray)
                    VStack{
                        Text(String(year))
                            .font(.caption)
                            .foregroundColor(Color.white)
                        Text(numToMonth(month: month))
                            .font(.headline)
                            .bold()
                            .foregroundColor(Color.white)
                    }
                    .padding(.horizontal,30)
                    .padding(.vertical, 10)
                    .background(Color.gray)
                    .cornerRadius(10)
                    Spacer()
                }
                .padding(50)
                Spacer()
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
                    Home(
                        year: 1,
                        month: 1,
                        drinks: [
                            DrinkLogRecord(drinkId: "m1", date: Date()),
                        ]
                    )
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
