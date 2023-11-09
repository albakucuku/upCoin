//
//  MainView.swift
//  upCoin
//
//  Created by Alba Kucuku on 4/25/23.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationView {
            VStack {
                switch selectedTab {
                case 0:
                    HomeView()
                case 1:
                    AssetsView()
                case 2:
                    TradesView()
                case 3:
                    NewsView()
                default:
                    HomeView()
                }
                
                Spacer()
                
                HStack {
                    Button(action: {
                        selectedTab = 0
                    }) {
                        VStack {
                            Image(systemName: "house")
                            Text("Home")
                        }
                    }
                    .foregroundColor(selectedTab == 0 ? .blue : .gray)
                    
                    Spacer()
                    
                    Button(action: {
                        selectedTab = 1
                    }) {
                        VStack {
                            Image(systemName: "chart.pie.fill")
                            Text("Assets")
                        }
                    }
                    .foregroundColor(selectedTab == 1 ? .blue : .gray)
                    
                    Spacer()
                    
                    Button(action: {
                        selectedTab = 2
                    }) {
                        VStack {
                            Image(systemName: "arrow.triangle.2.circlepath")
                            Text("Trade")
                        }
                    }
                    .foregroundColor(selectedTab == 2 ? .blue : .gray)
                    
                    Spacer()
                    
                    Button(action: {
                        selectedTab = 3
                    }) {
                        VStack {
                            Image(systemName: "newspaper.fill")
                            Text("News")
                        }
                    }
                    .foregroundColor(selectedTab == 3 ? .blue : .gray)
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HomView: View {
    var body: some View {
        Text("Home View")
    }
}

struct AssetView: View {
    var body: some View {
        Text("Assets View")
    }
}

struct TradeView: View {
    var body: some View {
        Text("Trade View")
    }
}

struct NewView: View {
    var body: some View {
        Text("News View")
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
