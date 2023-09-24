//
//  NetworkManager.swift
//  AboutTheWeather
//
//  Created by little-ac on 2023-09-23.
//

import Foundation

final class NetworkManager {
    
    enum ApiError: Error {
        case requestError
        case parsingError
        case responseError
        case serverError(code: Int)
        case unknownError
    }
    
    func makeRequest(from urlString: String) throws -> URLRequest {
        guard let url = URL(string: urlString) else {
            throw ApiError.requestError
        }
        return URLRequest(url: url)
    }
    
    func sendRequest<T: Decodable>(urlString: String,
                                   mapToDataModel: T.Type) async throws -> Result<T, ApiError> {
        
        let request = try makeRequest(from: urlString)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else { return .failure(.responseError) }
            
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(mapToDataModel, from: data) else {
                    return .failure(.parsingError)
                }
                return .success(decodedResponse)
            default: return .failure(.serverError(code: response.statusCode))
            }
            
        } catch {
            return .failure(.unknownError)
        }
    }
}
