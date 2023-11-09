//
//  AssetsView.swift
//  upCoin
//
//  Created by Alba Kucuku on 4/25/23.
//

import SwiftUI
import Combine

struct CoinAsset: Identifiable {
    let id = UUID()
    let name: String
    let symbol: String
    var balance: Double
    var price: Double
}

class CoinAssetsViewModel: ObservableObject {
    @Published var assets: [CoinAsset] = []
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        fetchAssets()
    }
    
    func fetchAssets() {
        let endpoint = "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin,ethereum,litecoin&vs_currencies=usd"
        
        URLSession.shared.dataTaskPublisher(for: URL(string: endpoint)!)
            .map { $0.data }
            .decode(type: [String: [String: Double]].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching assets: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] result in
                guard let self = self else { return }
                
                self.assets = [
                    CoinAsset(name: "Bitcoin", symbol: "BTC", balance: 1.25, price: result["bitcoin"]?["usd"] ?? 0),
                    CoinAsset(name: "Ethereum", symbol: "ETH", balance: 5.0, price: result["ethereum"]?["usd"] ?? 0),
                    CoinAsset(name: "Litecoin", symbol: "LTC", balance: 10.0, price: result["litecoin"]?["usd"] ?? 0)
                ]
            })
            .store(in: &cancellables)
    }
}

struct AssetsView: View {
    
    @ObservedObject private var viewModel = CoinAssetsViewModel()
    
    var body: some View {
        VStack {
            Text("My Assets")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            List(viewModel.assets) { asset in
                VStack(alignment: .leading, spacing: 10) {
                    Text(asset.name)
                        .font(.headline)
                        .fontWeight(.bold)
                    Text("\(asset.balance, specifier: "%.4f") \(asset.symbol)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    HStack {
                        Text("$\(asset.price, specifier: "%.2f")")
                            .font(.headline)
                            .fontWeight(.bold)
                        Spacer()
                        Text("$\(asset.balance * asset.price, specifier: "%.2f")")
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.green)
                }
            }
            
            Spacer()
        }
        .padding(.top, 30)
    }
}

struct AssetsView_Previews: PreviewProvider {
    static var previews: some View {
        AssetsView()
    }
}
