import Foundation

protocol NetworkManagerProtocol {
    func sendHTTPRequest(urlString: String, mapToDataModel: Codable.Type) async throws -> Result<APIResponse, NetworkManager.ApiError>
}


final class NetworkManager: NetworkManagerProtocol {
  
    /// An enumeration representing possible errors that can occur during API requests.
     enum ApiError: Error {
         /// An error indicating an issue with forming the request.
         case requestError

         /// An error indicating an issue with parsing the response data.
         case parsingError

         /// An error indicating an issue with the server's response.
         case responseError

         /// An error indicating a specific server error with an HTTP status code.
         case serverError(code: Int)

         /// An error indicating an unknown or unexpected error.
         case unknownError
     }

    /// Creates a `URLRequest` from a given URL string.
       ///
       /// - Parameter urlString: The URL string to create the request from.
       /// - Throws: An `ApiError` if the URL is invalid and cannot form a request.
       /// - Returns: A `URLRequest` object.
    func makeRequest(from urlString: String) throws -> URLRequest {
        guard let url = URL(string: urlString) else {
            throw ApiError.requestError
        }
        return URLRequest(url: url)
    }

    /// Sends an asynchronous request and parses the response into a specified data model.
        ///
        /// - Parameters:
        ///   - urlString: The URL string to send the request to.
        ///   - mapToDataModel: The data model type to decode the response into.
        /// - Throws: An `ApiError` if any errors occur during the request.
        /// - Returns: A `Result` containing either the decoded data model or an `ApiError`.
    func sendHTTPRequest(urlString: String, mapToDataModel: Codable.Type) async throws -> Result<APIResponse, ApiError> {
        
        let request = try makeRequest(from: urlString)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else { return .failure(.responseError) }
            
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(mapToDataModel, from: data) else {
                    return .failure(.parsingError)
                }
                return .success(decodedResponse as! APIResponse)
            default: return .failure(.serverError(code: response.statusCode))
            }
        } catch {
            return .failure(.unknownError)
        }
    }
}
