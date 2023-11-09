//
//  HomePageView.swift
//  upCoin
//
//  Created by Alba Kucuku on 4/25/23.
//

import SwiftUI

struct Coin: Codable {
    let name: String
    let symbol: String
    let price: Double
}

class API {
    static func fetchCoins(completion: @escaping ([Coin]) -> ()) {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin%2Cethereum%2Cripple%2Cbinancecoin%2Clitecoin&order=market_cap_desc&per_page=5&page=1&sparkline=false&price_change_percentage=1h%2C24h%2C7d") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                if let coins = try? decoder.decode([Coin].self, from: data) {
                    completion(coins)
                }
            }
        }.resume()
    }
}


struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(configuration.isPressed ? Color.gray : Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
            )
    }
}

struct HomePageView: View {
    
    @State private var selectedTab = 0
    @State private var balance: Double = 230.15 // example balance
    @State private var coins: [Coin] = []
    
    var body: some View {
        VStack {
            HStack {
                Text("My Balance")
                    .font(.headline)
                Spacer()
                Text("$\(balance, specifier: "%.2f")")
                    .font(.headline)
            }
            .padding(.horizontal)
            .padding(.top, 30)
            .padding(.bottom, 10)
            
            VStack(spacing: 20) {
                Button(action: {
                    // handle buy action
                }) {
                    HStack {
                        Image(systemName: "arrow.up.right.circle.fill")
                            .foregroundColor(.blue)
                            .font(.system(size: 30))
                        Text("Buy")
                            .foregroundColor(.primary)
                            .font(.headline)
                    }
                }
                .buttonStyle(CustomButtonStyle())
                
                Button(action: {
                    // handle send action
                }) {
                    HStack {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.purple)
                            .font(.system(size: 30))
                        Text("Send")
                            .foregroundColor(.primary)
                            .font(.headline)
                    }
                }
                .buttonStyle(CustomButtonStyle())
                
                Button(action: {
                    // handle receive action
                }) {
                    HStack {
                        Image(systemName: "qrcode.viewfinder")
                            .foregroundColor(.green)
                            .font(.system(size: 30))
                        Text("Receive")
                            .foregroundColor(.primary)
                            .font(.headline)
                    }
                }
                .buttonStyle(CustomButtonStyle())
                
                VStack {
                    Text("Popular Coins")
                        .font(.headline)
                    ForEach(coins, id: \.symbol) { coin in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(coin.name)
                                    .font(.headline)
                                Text(coin.symbol.uppercased())
                                    .font(.subheadline)
                            }
                            Spacer()
                            Text("$\(coin.price, specifier: "%.2f")")
                                .font(.headline)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 50)
        }
        .onAppear {
            API.fetchCoins { coins in
                self.coins = coins
            }
        }
    }
}


struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
