public protocol BottomAlertViewModel {
    var showingAlert: Bool { get set }
    var alertTitle: String { get set }
    var actionItems: [String] { get }
    var itemActions: [() -> ()] { get }
}


