import Foundation
import SwiftUI

public struct RoundedCorners: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    
    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
