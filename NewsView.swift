//
//  NewsView.swift
//  upCoin
//
//  Created by Alba Kucuku on 4/18/23.
//
import SwiftUI

struct NewsView: View {
    @State var articles: [Article] = []

    var body: some View {
        VStack {
            Text("Cryptocurrency News")
                .font(.title)
                .padding()
            
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(articles, id: \.url) { article in
                        VStack(alignment: .leading) {
                            Text(article.title)
                                .font(.headline)
                                .padding(.bottom, 5)
                            
                            Text(article.description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                    }
                }
                .padding()
            }
        }
        .onAppear {
            fetchArticles()
        }
    }
    
    func fetchArticles() {
        let headers = [            "content-type": "application/octet-stream",            "X-RapidAPI-Key": "***ENTER YOUR API KEY HERE***",            "X-RapidAPI-Host": "crypto-news16.p.rapidapi.com"        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://crypto-news16.p.rapidapi.com/news/top/5")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                if let data = data {
                    if let jsonString = String(data: data, encoding: .utf8) {
                        let jsonData = jsonString.data(using: .utf8)!
                        if let decodedResponse = try? JSONDecoder().decode([Article].self, from: jsonData) {
                            DispatchQueue.main.async {
                                self.articles = decodedResponse
                            }
                        }
                    }
                }
            }
        })

        dataTask.resume()
    }
}

struct Article: Codable, Identifiable {
    var id: String { url }
    let title: String
    let description: String
    let url: String
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
