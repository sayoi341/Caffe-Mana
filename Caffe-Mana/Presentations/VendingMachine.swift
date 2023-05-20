import SwiftUI
import ComposableArchitecture



struct VendingMachine: View {
    let topData: [String]
    let bottomData:[String]
    let store: StoreOf<AddConfarm>
    
    init(topData: [String], bottomData: [String], store: StoreOf<AddConfarm>) {
        self.topData = topData
        self.bottomData = bottomData
        self.store = store
    }
    
    
    var body: some View{
        
        WithViewStore(self.store) { viewStore in
            GeometryReader { geoBackground in
                ZStack {
                    Rectangle()
                        .fill(Color(red: 1.0, green: 0.427, blue: 0.439))
                        .frame(width: geoBackground.size.width*0.9, height: geoBackground.size.height * 0.9)
                        .cornerRadius(10)
                    HStack{
                        GeometryReader { geoInner in
                            VStack (spacing: 0) {
                                ZStack{
                                    Color("background").cornerRadius(10)
                                    VStack(spacing: 0){
                                        GeometryReader{ geoTop in
                                            HStack(alignment: .center,spacing: geoTop.size.width * 0.05){
                                                ForEach(topData, id: \.self) { data in
                                                    Button(action: {
                                                        viewStore.send(.setAddDataKey(id: data))
                                                        viewStore.send(.openConfarm)
                                                    }){
                                                        VendingMachineButton(drinkId: data, height: geoTop.size.height * 0.8, width: geoTop.size.width * 0.2)
                                                    }
                                                }
                                            }
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        }
                                        .frame(height: geoInner.size.height*0.34)
                                        
                                        Rectangle()
                                            .fill(Color(red: 1.0, green: 0.427, blue: 0.439))
                                            .frame(height: geoInner.size.height * 0.02)
                                        
                                        GeometryReader{ geoBottom in
                                            HStack(alignment: .center,spacing: geoBottom.size.width * 0.05){
                                                ForEach(bottomData, id: \.self) { data in
                                                    Button(action: {
                                                        viewStore.send(.setAddDataKey(id: data))
                                                        viewStore.send(.openConfarm)
                                                    }){
                                                        VendingMachineButton(drinkId: data, height: geoBottom.size.height * 0.8, width: geoBottom.size.width * 0.2)
                                                    }
                                                }
                                            }
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        }
                                        .frame(height: geoInner.size.height*0.34)
                                    }
                                }
                                .frame(height: geoInner.size.height*0.7)
                                HStack{
                                    ZStack{
                                        Color("background")
                                            .cornerRadius(10)
                                        Text("Caffe Mana")
                                            .font(.title)
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color(red:0.26, green:0.26, blue:0.25))
                                    }
                                    .frame(width: geoInner.size.width*0.55, height: geoInner.size.height * 0.1)
                                    HStack{
                                        SVGImage(name: "paperMoney")
                                            .frame(width: geoInner.size.width*0.15, height: geoInner.size.width*0.075)
                                    }
                                    .frame(width: geoInner.size.width*0.15, height: geoInner.size.height * 0.1)
                                    
                                    SVGImage(name: "coin")
                                        .frame(width: geoInner.size.width*0.15, height: geoInner.size.width*0.135)
                                }
                                .frame(height: geoInner.size.height*0.15)
                                HStack{
                                    ZStack(alignment: .top){
                                        Color(red: 0.85, green: 0.85, blue: 0.85)
                                        Color(red: 0.65, green: 0.65, blue: 0.65)
                                            .frame(height: geoInner.size.height*0.05)
                                    }
                                    .frame(height: geoInner.size.height*0.125)
                                    .cornerRadius(10)
                                    Rectangle()
                                        .fill(Color(red: 0.85, green: 0.85, blue: 0.85))
                                        .frame(width: geoInner.size.width*0.15, height: geoInner.size.width*0.1)
                                        .cornerRadius(8)
                                }
                                
                                .frame(height: geoInner.size.height*0.125)
                            }
                        }
                    }
                    .frame(width: geoBackground.size.width*0.8, height: geoBackground.size.height*0.9 - geoBackground.size.width*0.1)
                    VStack{
                        if viewStore.isDropShow {
                            SVGImage(name: viewStore.addData.fileName)
                                .frame(width: 50, height:120)
                            
                        }
                    }
                            .frame(width: 50, height:120)
                            .rotationEffect(Angle(degrees: 90))
                            .offset(x:-geoBackground.size.width*0.05, y: viewStore.isDropStart ? geoBackground.size.height*0.5 : geoBackground.size.height*0.32)
                            .animation(.linear(duration: viewStore.isDropStart ? 0.2 : 0), value: viewStore.isDropStart)
                            .opacity(1)
                            .onChange(of: viewStore.isDropStart) { new in
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                                    viewStore.send(.endDrop)
                                    viewStore.send(.setIsDropShow(status: false))
                                }
                            }
                }
                .offset(x: geoBackground.size.width*0.05, y: geoBackground.size.height*0.1)
            }
            .frame(width: .infinity, height: .infinity)
            .clipped()
        }
    }
}

struct VendingMachine_Previews: PreviewProvider {
    static var previews: some View {
        Layout(
            store: Store(
                initialState: Root.State(),
                reducer: Root()
            ),
            home: {
                VendingMachine(
                    topData: ["m1","m2", "m3","m4"],
                    bottomData: ["m5","m6", "m7","m8"],
                    store: Store(
                        initialState: AddConfarm.State(),
                        reducer: AddConfarm()
                    )
                )
            },
            add: {
                Text("add")
            },
            setting: {
                Text("setting")
            }
        )
    }
}
