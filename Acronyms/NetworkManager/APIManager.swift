//
//  APIManager.swift
//  Acronyms
//
//  Created by Anusha G on 10/27/21.
//

import UIKit

final class APIManager {
    
    static let shared = APIManager()
    private func Init(){}
    
    public func getAcronymsResults<T: Decodable>(forText searchQuery: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard !searchQuery.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        let urlString = Constants.baseSearchURL + searchQuery
        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, _,error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let results = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(results))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }

}
