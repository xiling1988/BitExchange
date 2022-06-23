//
//  CurrencyManager.swift
//  BitExchange
//
//  Created by Emirates on 22/06/2022.
//

import Foundation

class CurrencyManager : ObservableObject {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "60C99464-D1C7-4961-8F16-F0C31A6EFFFE"
    
    let currencyArray = ["USD","AUD","BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","ZAR"]
    var currency = "USD"
    
    func getCoinPrice(for currency: String) async throws -> ExchangeModel {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        
        guard let url = URL(string: urlString) else { fatalError("Missing URL")}
            let urlRequest = URLRequest(url: url)
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {fatalError("Error while fetching")}
            
            let decodedExchange = try JSONDecoder().decode(ExchangeModel.self, from: data)
            return decodedExchange
        }
        
    }
    
    
    
    
//    func performRequest(urlString: String) async -> String {
//        var rate = "duh"
//        if let url = URL(string: urlString)  {
//
//            let session = URLSession(configuration: .default)
//
//
//            let task = session.dataTask(with: url) { data, response, error in
//
//                if error != nil {
//                    print(error!)
//                    rate = "0.0"
//                }
//
//                if let safeData = data {
//                    if let exchange = self.parseJSON(exchange: safeData) {
//                        rate = String(format: "%.2f", exchange.rate)
//                    }
//                }
//            }
//            task.resume()
//        }
//        print(rate)
//        return rate
//    }
//
//    func parseJSON(exchange: Data) -> ExchangeModel?{
//        let decoder = JSONDecoder()
//
//        do {
//            let decodedData = try decoder.decode(ExchangeModel.self, from: exchange)
//            let rate = decodedData.rate
//            let assetID = decodedData.asset_id_quote
//            return ExchangeModel(asset_id_quote: assetID, rate: rate)
//
//        } catch {
//            print(error)
//            return nil
//        }
//    }
//}
