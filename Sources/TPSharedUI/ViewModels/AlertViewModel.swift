public protocol AlertViewModel {
    var showingActionOptions: Bool { get set }
    var actionItems: [String] { get }
    var itemActions: [() -> ()] { get }
}


