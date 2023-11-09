//
//  ContentView.swift
//  upCoin
//
//  Created by Alba Kucuku on 4/4/23.
//

import SwiftUI

struct ContentView: View {
    @State var username: String = ""
    @State var password1: String = ""
    @State private var resultMessage: String = ""
    @State var isLoggedIn = false
    @State var showError = false

    var body: some View {
        NavigationView {
            ZStack {
                Color("Color")
                    .ignoresSafeArea()
                
                VStack {
                    Group {
                        Image("logo")
                            .resizable()
                            .frame(width: 300, height: 300, alignment: .bottom)
                        TextField("Enter Username", text: $username)
                            .textFieldStyle(.roundedBorder)
                        
                        TextField("Enter Password", text: $password1)
                            .textFieldStyle(.roundedBorder)
                        
                        // Create User button
                        Button(action: {
                            Task {
                                if !username.isEmpty && !password1.isEmpty {
                                    await sendNewUserData()
                                } else {
                                    showError = true
                                }
                            }
                        }, label: {
                            Text("CREATE ACCOUNT")
                                .font(.title3)
                                .padding()
                        })
                        
                        //LOGIN User button
                        Button(action: {
                            Task {
                                if !username.isEmpty && !password1.isEmpty {
                                    await loginUserData()
                                } else {
                                    showError = true
                                }
                            }
                        }, label: {
                            Text("LOGIN INTO ACCOUNT")
                                .font(.title3)
                                .padding()
                        })
                        
                        HStack {
                            Text("Status : ")
                            
                            Text(resultMessage)
                                .frame(width: 275, height: 70, alignment: .leading)
                                .background(Color.blue)
                                .foregroundColor(Color.white)
                        } // end HStack
                    } // end group
                } // end of VStack
                .alert(isPresented: $showError, content: {
                    Alert(title: Text("Error"), message: Text("Please enter a username and password"), dismissButton: .default(Text("OK")))
                })
            } // end of ZStack
        } // end NavigationView
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        .fullScreenCover(isPresented: $isLoggedIn) {
            MainView()
        } // end fullScreenCover
    } // end body
    
    
    func loginUserData() async {
        resultMessage = "Processing, one moment..."
        
        //
        // create some substrings
        //
        let userStr = "username=" + username
        let passStr = "&password=" + password1
        
        //
        // prepare URL
        //
        let url = URL(string: "https://storm.cis.fordham.edu/~kounavelis/cgi-bin/loginUserCS4400.cgi")
        
        guard let requestUrl = url else { fatalError() }
        
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // HTTP Request Parameters which will be sent in HTTP Request body
        let postString = userStr + passStr
        
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        // Perform HTTP Request
        let (data, response) = try! await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode == 200 {
                resultMessage = String(data: data, encoding: .utf8) ?? ""
                username = ""
                password1 = ""
                isLoggedIn = true
            } else {
                resultMessage = "Error took place. Status code: \(httpResponse.statusCode)"
            }
        } else {
            resultMessage = "Error took place. Response was nil."
        }
    }
    
    func sendNewUserData() async {
        resultMessage = "Processing, one moment..."
        
        //
        // create some substrings
        //
        let userStr = "username=" + username
        let passStr = "&password=" + password1
        
        //
        // Prepare uRL
        //
        let url = URL(string: "https://storm.cis.fordham.edu/~kounavelis/cgi-bin/createUserCS4400.cgi")
        
        guard let requestUrl = url else { fatalError() }
        
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = userStr + passStr
        
        // set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // check for error
            if let error = error {
                resultMessage = "Error took place \(error)"
                return
            }
            
            // Convert HTTP Response to a String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                        resultMessage = "Resp:\(dataString)"
                        
                        username  = ""
                        password1 = ""
                        isLoggedIn = true // Set isLoggedIn to true when login is successful
                    }
        } // end task
        
        task.resume()
        
    } // end function sendNewCustomerData
    
} // end struct

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
    }
}
