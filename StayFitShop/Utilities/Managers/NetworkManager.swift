//
//  NetworkManager.swift
//  StayFitShop
//
//  Created by Viktor Mauzer on 31.05.2022..
//

import Foundation

struct NetworkManager {
    func getProducts() async throws -> [Product]? {
        let url = URL(string: "https://viktormauzer.github.io/files/portfolio-shop/products.json")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/JSON", forHTTPHeaderField: "Content-Type")
        
        let decoder = JSONDecoder()
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedData = try decoder.decode([Product].self, from: data)
            return decodedData
        } catch {
            throw error
        }
    }
    
    func placeOrder(_ order: Order) async throws {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("failed to encode products")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/shopping-app")! // URL that responds back with same data just for testing purposes
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/JSON", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let _ = try? JSONDecoder().decode(Order.self, from: data)
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
}
