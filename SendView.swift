//
//  SendView.swift
//  upCoin
//
//  Created by Alba Kucuku on 4/25/23.
//

import SwiftUI

struct SendView: View {
    @State private var address = ""
    @State private var amount = ""
    @State private var selectedCrypto = 0
    
    var cryptoOptions = ["Bitcoin", "Ethereum", "Litecoin"]
    
    var body: some View {
        VStack {
            Text("Send Crypto")
                .font(.title)
                .bold()
                .padding(.bottom, 30)
            
            Picker(selection: $selectedCrypto, label: Text("Select Crypto")) {
                ForEach(0 ..< cryptoOptions.count) {
                    Text(self.cryptoOptions[$0])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.bottom, 30)
            
            TextField("Address", text: $address)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 10)
            
            TextField("Amount", text: $amount)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 30)
            
            Button(action: {
                // Code to send crypto
            }) {
                Text("Send")
                    .frame(width: 100, height: 50)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

struct SendView_Previews: PreviewProvider {
    static var previews: some View {
        SendView()
    }
}
