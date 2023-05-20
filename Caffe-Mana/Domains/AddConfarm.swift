import ComposableArchitecture

struct AddConfarm: ReducerProtocol {
    
    struct State: Equatable {
        var isConfarmOpen: Bool = false
        var isDropStart:Bool = false
        var isDropShow:Bool = false
        var addData: DrinkData = DrinkData(name: "nil", cafeine: 0, price: 0, volume: 0, fileName: "nil")
    }
    
    enum Action: Equatable{
        case openConfarm
        case closeConfarm
        case startDrop
        case endDrop
        case setAddDataKey(id: String)
        case setIsDropShow(status:Bool)
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action>{
        switch action {
        case let Action.setAddDataKey(id):
            let d = drinkData[id]
            if let drink = d {
                state.addData = drink
            } else {
                state.addData = DrinkData(name: "nil", cafeine: 0, price: 0, volume: 0, fileName: "nil")
            }
            return .none
        case .openConfarm:
            state.isConfarmOpen = true
            return .none
        case .closeConfarm:
            state.isConfarmOpen = false
            return .none
        case .startDrop:
            state.isDropStart = true
            return .none
        case .endDrop:
            state.isDropStart = false
            return .none
        case let Action.setIsDropShow(status):
            state.isDropShow = status
            return.none
        }
    }
}
