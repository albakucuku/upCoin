//
//  TradesView.swift
//  upCoin
//
//  Created by Alba Kucuku on 4/27/23.
//
import SwiftUI

struct TradesView: View {
    @State private var selectedCurrency: String = "Bitcoin"
    @State private var graphData: [Double] = []
    
    var body: some View {
        VStack {
            Text("Trade Page")
                .font(.largeTitle)
                .padding()
            
            Picker("Select Currency", selection: $selectedCurrency) {
                Text("Bitcoin").tag("Bitcoin")
                Text("Ethereum").tag("Ethereum")
                Text("Litecoin").tag("Litecoin")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Button(action: {
                fetchGraphData()
            }) {
                Text("Refresh Graph")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
            
            if graphData.isEmpty {
                Text("No data available")
                    .foregroundColor(.gray)
            } else {
                LineGraph(data: graphData)
                    .aspectRatio(1, contentMode: .fit)
                    .padding()
            }
            
            Spacer()
        }
    }
    
    func fetchGraphData() {
        let currencySymbol: String
        
        switch selectedCurrency {
        case "Bitcoin":
            currencySymbol = "bitcoin"
        case "Ethereum":
            currencySymbol = "ethereum"
        case "Litecoin":
            currencySymbol = "litecoin"
        default:
            return
        }
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(currencySymbol)/market_chart?vs_currency=usd&days=30") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(GraphDataResponse.self, from: data)
                    self.graphData = response.prices.map { $0[1] }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            } else if let error = error {
                print("API request error: \(error)")
            }
        }.resume()
    }
}

struct LineGraph: View {
    var data: [Double]
    
    var body: some View {
        // Render the line graph using the provided data
        // Customize the appearance and styling as per your requirements
        
        GeometryReader { geometry in
            Path { path in
                let minY = data.min() ?? 0
                let maxY = data.max() ?? 1
                let yRange = maxY - minY
                let yRatio = geometry.size.height / CGFloat(yRange)
                
                for (index, value) in data.enumerated() {
                    let x = CGFloat(index) * (geometry.size.width / CGFloat(data.count - 1))
                    let y = geometry.size.height - CGFloat(value - minY) * yRatio
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: x, y: y))
                    } else {
                        path.addLine(to: CGPoint(x: x, y: y))
                    }
                }
            }
            .stroke(Color.green, lineWidth: 2)
        }
    }
}

struct GraphDataResponse: Decodable {
    var prices: [[Double]]
}

struct TradesView_Previews: PreviewProvider {
    static var previews: some View {
        TradesView()
    }
}
