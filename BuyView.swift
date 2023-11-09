//
//  BuyView.swift
//  upCoin
//
//  Created by Alba Kucuku on 4/25/23.
//

import SwiftUI

struct BuyView: View {
    @State private var selectedCrypto = 0
    @State private var selectedCurrency = 0
    @State private var amount = ""
    
    var cryptoOptions = ["Bitcoin", "Ethereum", "Litecoin"]
    var currencyOptions = ["USD", "EUR", "GBP"]
    
    var body: some View {
        VStack {
            Text("Buy Crypto")
                .font(.title)
                .bold()
                .padding(.bottom, 30)
            
            Picker(selection: $selectedCrypto, label: Text("Select Crypto")) {
                ForEach(0 ..< cryptoOptions.count) {
                    Text(self.cryptoOptions[$0])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.bottom, 20)
            
            Picker(selection: $selectedCurrency, label: Text("Select Currency")) {
                ForEach(0 ..< currencyOptions.count) {
                    Text(self.currencyOptions[$0])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.bottom, 20)
            
            TextField("Amount", text: $amount)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 30)
            
            Button(action: {
                // Code to buy crypto
            }) {
                Text("Buy")
                    .frame(width: 100, height: 50)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

struct BuyView_Previews: PreviewProvider {
    static var previews: some View {
        BuyView()
    }
}
