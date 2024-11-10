import SwiftUI

struct NoUserView: View {
    @State private var selectedTab: Int = 1
    let accentColor: Color = Color.orange
    let baseColor: Color = Color.white
    private let gridLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    let samplePositions = [
        PositionItem(title: "Software Developer", industry: "Entertainment"),
        PositionItem(title: "Full Stack Developer", industry: "Technology"),
        PositionItem(title: "Cybersecurity Specialist", industry: "Technology"),
        PositionItem(title: "Web Designer", industry: "Finance")
    ]
    
    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                VStack {
                    Text("Log in or register to access all features like:")
                        .font(.body)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.top, 20)

                    VStack(alignment: .center, spacing: 5) {
                        Text("• AI-based matching based on profile")
                        Text("• Swipe-to-apply (Will send you aplication to employeer)")
                        Text("• Bias-free recruitment")
                        Text("and much more!")
                    }
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)

                    Text("Open Positions:")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(.top, 10)
                    
                    // Display sample positions in a grid
                    LazyVGrid(columns: gridLayout, alignment: .center, spacing: 20) {
                        ForEach(samplePositions) { position in
                            VStack(alignment: .leading, spacing: 5) {
                                Text(position.title)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                
                                Text("in \(position.industry)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .shadow(radius: 2)
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .tabItem {
                    Image(systemName: "chair.fill")
                        .font(.title)
                    Text("Jobs")
                }
                .tag(1)
                
                Text("Login or Register to view your matches.")
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding()
                    .tabItem {
                        Image(systemName: "message.fill")
                            .font(.title)
                        Text("Matches")
                    }
                    .tag(0)
                
                Text("Create an account to access profile features.")
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding()
                    .tabItem {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.title)
                        Text("Profile")
                    }
                    .tag(2)
            }
            .accentColor(accentColor)
            .onAppear {
                UITabBar.appearance().unselectedItemTintColor = UIColor(baseColor)
            }
        }
        .environment(\.colorScheme, .light)
    }
}

struct PositionItem: Identifiable {
    let id = UUID()
    let title: String
    let industry: String
}

struct NoUserView_Previews: PreviewProvider {
    static var previews: some View {
        NoUserView()
    }
}
 
