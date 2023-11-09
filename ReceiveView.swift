//
//  ReceiveView.swift
//  upCoin
//
//  Created by Alba Kucuku on 4/25/23.
//

import SwiftUI

struct ReceiveView: View {
    @State private var selectedCrypto = 0
    
    var cryptoOptions = ["Bitcoin", "Ethereum", "Litecoin"]
    
    var body: some View {
        VStack {
            Text("Receive Crypto")
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
            
            Image(systemName: "qrcode")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .padding(.bottom, 30)
            
            Text("Your Address:")
                .font(.headline)
                .padding(.bottom, 10)
            
            Text("1AbcDefGhiJklMnoPqrStuVwxYz")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.bottom, 30)
            
            Button(action: {
                // Code to copy address to clipboard
            }) {
                Text("Copy Address")
                    .frame(width: 150, height: 50)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

struct ReceiveView_Previews: PreviewProvider {
    static var previews: some View {
        ReceiveView()
    }
}
