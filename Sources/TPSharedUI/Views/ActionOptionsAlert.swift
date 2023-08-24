import SwiftUI

public class ToggleState: ObservableObject {
    @Published var isToggleOn = false
}

public struct ActionOptionsAlert: View {
    @State var actionViewModel: AlertViewModel?
    @ObservedObject var showingActionOptions: ToggleState
    
    var body: some View {
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
                    RoundedCorners(radius: 16, corners: [.bottomLeft, .bottomRight])
                        .fill(Color(hex: 0xfafae6))
                        .frame(width: UIScreen.main.bounds.width - 90, height: 56.25 * CGFloat((actionViewModel?.itemActions.count ?? 1)))
                }
                
                
                VStack(spacing: 8) {
                    if let actionViewModel = actionViewModel {
                        ForEach(actionViewModel.actionItems.indices, id: \.self) { index in
                            let actionTitle = actionViewModel.actionItems[index]
                            Text(actionViewModel.actionItems[index])
                                .font(actionTitle == "Cancel" ? .custom("Helvetica-Bold", size: 16) : .custom("Helvetica", size: 16))
                                .foregroundColor(actionTitle == "Block" ? .black : .black)
                                .padding(8)
                                .onTapGesture {
                                    actionViewModel.itemActions[index]()
                                }
                            if index < (actionViewModel.actionItems.count) - 1 {
                                Rectangle()
                                    .fill(Color(hex: 0xf2f2ed))
                                    .frame(width: UIScreen.main.bounds.width - 90, height: 0.5)
                            }
                        }
                        .offset(y: 12)
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 140)
            }
        }
    }
}

struct ActionOptionsAlert_Previews: PreviewProvider {
    static var previews: some View {
        ActionOptionsAlert(actionViewModel: nil, showingActionOptions: ToggleState())
    }
}
