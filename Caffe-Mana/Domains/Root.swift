import ComposableArchitecture

enum StateType {
    case home
    case add
    case setting
}

struct Root: ReducerProtocol {
    struct State: Equatable {
        var view:StateType = .home
        var isReceiptOpen: Bool = false
    }
    
    enum Action: Equatable {
        case viewHome
        case viewAdd
        case viewSetting
        case openReceipt
        case closeReceipt
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .viewHome:
            state.view = .home
            return .none
        case .viewAdd:
            state.view = .add
            return .none
        case .viewSetting:
            state.view  = .setting
            return .none
        case .openReceipt:
            state.isReceiptOpen = true
            return .none
        case .closeReceipt:
            state.isReceiptOpen = false
            return .none
        }
    }
}
