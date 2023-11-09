//
//  HomeView.swift
//  upCoin
//
//  Created by Alba Kucuku on 4/25/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "bitcoinsign.circle.fill")
                        .font(.system(size: 35))
                        .foregroundColor(.blue)
                    Text("Crypto Tracker")
                        .font(.title)
                        .bold()
                }
                .padding(.top, 40)
                .padding(.bottom, 20)
                
                Text("Your Assets")
                    .font(.headline)
                    .padding(.bottom, 10)
                
                // Add a List view to display the user's assets
                List {
                    // Add your assets to the List view
                    Text("Bitcoin: 0.5")
                    Text("Ethereum: 2.0")
                    Text("Litecoin: 1.0")
                }
                .frame(height: 150)
                .padding(.bottom, 20)
                
                // Add buttons for Buy, Send, and Receive
                HStack {
                    NavigationLink(destination: BuyView()) {
                        Text("Buy")
                            .frame(width: 100, height: 50)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    NavigationLink(destination: SendView()) {
                        Text("Send")
                            .frame(width: 100, height: 50)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    NavigationLink(destination: ReceiveView()) {
                        Text("Receive")
                            .frame(width: 100, height: 50)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                
                // Add sections for Crypto Prices, Live Trade Information, and News
                Section(header: Text("Crypto Prices").font(.headline)) {
                    // Add a Text view to display the latest crypto prices
                    Text("Bitcoin: $55,000")
                    Text("Ethereum: $2,000")
                    Text("Litecoin: $250")
                }
                
                Section(header: Text("Live Trade Information").font(.headline)) {
                    // Add a Text view to display the latest trade information
                    Text("BTC/USD: $55,100")
                    Text("ETH/USD: $2,020")
                    Text("LTC/USD: $255")
                }
                
                Section(header: Text("News").font(.headline)) {
                    // Add a Text view to display the latest news
                    Text("Crypto Market Sees Huge Growth in 2022")
                    Text("Bitcoin Reaches New All-Time High")
                    Text("Ethereum Price Surges Amidst DeFi Boom")
                }
            }
            .padding(.horizontal)
            .navigationBarHidden(true)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

