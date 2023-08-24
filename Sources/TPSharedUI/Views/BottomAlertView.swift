import SwiftUI

public struct BottomAlertView: View {
    @State var bottomAlertViewModel: BottomAlertViewModel?
    @ObservedObject var showingMenu: ToggleState
    
    public init(bottomAlertViewModel: BottomAlertViewModel? = nil, showingMenu: ToggleState) {
        _bottomAlertViewModel = State(initialValue: bottomAlertViewModel)
        self.showingMenu = showingMenu
    }
    
    public var body: some View {
        VStack {
            /*ZStack {
                Color.black.opacity(showingMenu.isToggleOn ? 0.8 : 0)
                    .edgesIgnoringSafeArea(.all)
                    .animation(.easeInOut, value: showingMenu.isToggleOn)
                    .frame(height: UIScreen.main.bounds.height)
            }*/
            
        VStack(spacing: 15) {
            Text(bottomAlertViewModel?.alertTitle ?? "")
                .font(.title2)
                .bold()
            
            if let bottomAlertViewModel = bottomAlertViewModel {
                
                ForEach(bottomAlertViewModel.actionItems.indices, id: \.self) { index in
                    let actionTitle = bottomAlertViewModel.actionItems[index]
                    Text(actionTitle)
                        .onTapGesture {
                            bottomAlertViewModel.itemActions[index]()
                        }
                    
                    if index < (bottomAlertViewModel.actionItems.count) - 1 {
                        Rectangle()
                            .fill(Color(hex: 0xf2f2ed))
                            .frame(width: UIScreen.main.bounds.width - 90, height: 0.5)
                    }
                }
            }
        }
        .frame(width: 350, height: 56.25 * CGFloat((bottomAlertViewModel?.itemActions.count ?? 1)))
        .background(Color(hex: 0xfafae6))
        .cornerRadius(20.0)
        
        HStack {
            Text("Cancel")
                .bold()
                .onTapGesture {
                    bottomAlertViewModel?.itemActions.last!()
                }
        }
        .padding(15)
        .frame(width: 350, height: 50)
        .background(Color(hex: 0xfafae6))
        .cornerRadius(12)
        }
    }
}

public struct BottomAlertView_Previews: PreviewProvider {
    public static var previews: some View {
        BottomAlertView(showingMenu: ToggleState())
    }
}
