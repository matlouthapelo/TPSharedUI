import SwiftUI

public struct BasicAlertView: View {
    @State var basicAlertViewModel: BasicAlertViewModel?
    @ObservedObject var showingActionOptions: ToggleState
    
    public init(basicAlertViewModel: BasicAlertViewModel? = nil, showingActionOptions: ToggleState) {
        _basicAlertViewModel = State(initialValue: basicAlertViewModel)
        self.showingActionOptions = showingActionOptions
    }
    
    private func calculateContentHeight(forText: String) -> CGFloat {
        let textWidth = UIScreen.main.bounds.width - 90 - 20 // Subtract 20 to leave some padding on the sides
        let text = forText
        let font = UIFont.preferredFont(forTextStyle: .title3)
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font]
        let size = (text as NSString).boundingRect(with: CGSize(width: textWidth, height: CGFloat.greatestFiniteMagnitude),
                                                   options: .usesLineFragmentOrigin,
                                                   attributes: attributes,
                                                   context: nil).size
        return size.height + 140 // Adding 120 to account for the other elements in the VStack
    }
    
    public var body: some View {
        VStack {
            ZStack {
                Color.black.opacity(showingActionOptions.isToggleOn ? 0.8 : 0)
                                        .edgesIgnoringSafeArea(.all)
                                        .animation(.easeInOut, value: showingActionOptions.isToggleOn)
                                        .frame(height: UIScreen.main.bounds.height)
                VStack {
                    
                    RoundedCorners(radius: 40, corners: [.topLeft, .topRight])
                        .fill(.red)
                        .frame(width: UIScreen.main.bounds.width - 90, height: 20)
                        .clipped()
                        .offset(y: 10)
                        .zIndex(2)
                    
                    ZStack {
                        if let basicAlertViewModel = basicAlertViewModel {
                            RoundedCorners(radius: 16, corners: [.bottomLeft, .bottomRight])
                                .fill(Color(hex: 0xfafae6))
                                .frame(width: UIScreen.main.bounds.width - 90, height: calculateContentHeight(forText: basicAlertViewModel.alertMessage + (basicAlertViewModel.negativeActionTitle.count > basicAlertViewModel.positiveActionTitle.count ? basicAlertViewModel.negativeActionTitle : basicAlertViewModel.positiveActionTitle))) //56.25 * CGFloat((basicAlertViewModel?.itemActions.count ?? 1))
                        }
                        VStack {
                            Text(basicAlertViewModel?.alertTitle ?? "")
                                .font(.title2)
                                .bold()
                                .padding()
                                .frame(maxWidth: UIScreen.main.bounds.width - 120)
                                .offset(y: -5)
                            
                            Text(basicAlertViewModel?.alertMessage ?? "")
                                .font(.system(size: 16))
                                .frame(maxWidth: UIScreen.main.bounds.width - 120)
                                .multilineTextAlignment(.center)
                                .offset(y: -10)
                            
                            Rectangle()
                                .frame(width: UIScreen.main.bounds.width - 90, height: 1)
                                .foregroundColor(.gray)
                            
                            HStack {
                                Button {
                                    basicAlertViewModel?.negativeAction()
                                } label: {
                                    Text(basicAlertViewModel?.negativeActionTitle ?? "")
                                        .font(.system(size: 16.5))
                                }
                                .frame(width: (UIScreen.main.bounds.width - 120) / 2)
                                
                                Rectangle()
                                    .frame(width: 1, height: 50)
                                    .foregroundColor(.gray)
                                
                                Button {
                                    basicAlertViewModel?.positiveAction()
                                } label: {
                                    Text(basicAlertViewModel?.positiveActionTitle ?? "")
                                        .font(.system(size: 16.5))
                                }
                                .frame(width: (UIScreen.main.bounds.width - 120) / 2)

                            }
                        }
                    }
                }
            }
        }
    }
}

public struct BasicAlertView_Previews: PreviewProvider {
    public static var previews: some View {
        BasicAlertView(basicAlertViewModel: nil, showingActionOptions: ToggleState())
    }
}
