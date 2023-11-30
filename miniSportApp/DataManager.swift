//
//  DataManager.swift
//  miniSportApp
//
//  Created by Joanne Monaghan on 19/10/2023.
//

import UIKit

enum DataManagerError: Error {
    case urlFailed
    case dataFailed
    case UrlSessionError
    case decodingFailed
}

class DataManager {
    
    func loadData(url: String, completion: @escaping (Result<Top, DataManagerError>) -> Void) {
        
        guard let url = URL(string: url) else {
            completion(.failure(.urlFailed))
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            guard error == nil else {
                completion(.failure(.UrlSessionError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.dataFailed))
                return
            }
            
            guard let decodedData = try? JSONDecoder().decode(Top.self, from: data) else {
                completion(.failure(.decodingFailed))
                return
            }
            
            completion(.success(decodedData))
            
        }.resume()
    }
}
