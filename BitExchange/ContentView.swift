//
//  ContentView.swift
//  BitExchange
//
//  Created by Emirates on 21/06/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var currencyManager = CurrencyManager()
    
    
    @State var currency : String = "USD"
    @State var exchange : ExchangeModel?
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "bitcoinsign.circle")
                Text("BitExchange")
                
            }
            .font(.largeTitle)
                Divider()
            
            HStack {
                Image(systemName: "bitcoinsign.circle.fill")
                Text("1 BTC")
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(height: 70)
                        .foregroundColor(.white)
                    VStack {
                        if let exchange = exchange {
                            Text("\(String(format: "%.2f", exchange.rate))")
                                .foregroundColor(.mint)
                                .font(.title3)
                        }
                    }
                    .task {
                        do {
                            exchange = try await currencyManager.getCoinPrice(for: currency)
                        } catch {
                            print(error)
                        }
                    }
                }
                Text(currency)
                    .onChange(of: currency) { newValue in
                        Task {
                        do {
                            exchange = try await currencyManager.getCoinPrice(for: newValue)
                        } catch {
                            print(error)
                        }
                        }
                    }
                Image(systemName: "banknote.fill")
            }
            .padding()
            .font(.title)
                Spacer()
            Picker("Picker", selection: $currency, content: {
                let currencies = currencyManager.currencyArray
                ForEach(0..<currencies.count, id: \.self) { currency in
                    Text(currencies[currency]).tag(currencies[currency])
                }
            })
            .pickerStyle(.wheel)
            Spacer()
            }
        .background(Color.mint)
    }
        
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
