//
//  ElementsAPI.swift
//  Elements
//
//  Created by Christian Hurtado on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct ElementsSearchAPIClient {
    static func getElements(for elements: [Element],
                            completion: @escaping (Result <[Element], AppError>) -> ()) {
        
        let elementEndpointUrl = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
        
        guard let url = URL(string: elementEndpointUrl) else {
            completion(.failure(.badURL(elementEndpointUrl)))
            return
        }
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let elements = try JSONDecoder().decode([Element].self, from: data)
                    completion(.success(elements))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
    static func postFave(elements: Element,
                         completion: @escaping (Result<Bool, AppError>) -> ()){
    
    let elementEndpointUrl = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites"
    
    guard let url = URL(string: elementEndpointUrl) else {
        completion(.failure(.badURL(elementEndpointUrl)))
        return
    }
    do {
        let data = try JSONEncoder().encode(elements)
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        request.httpMethod = "POST"
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success:
                completion(.success(true))
            }
        }
    } catch {
        completion(.failure(.decodingError(error)))
    }
    }
}
