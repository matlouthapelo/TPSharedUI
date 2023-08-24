public protocol BasicAlertViewModel {
    var showingActionOptions: Bool { get set }
    var alertTitle: String { get set }
    var alertMessage: String { get set }
    var negativeActionTitle: String { get }
    var positiveActionTitle: String { get }
    var negativeAction: () -> () { get }
    var positiveAction: () -> () { get }
}

