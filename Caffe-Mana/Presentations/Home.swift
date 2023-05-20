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
