import Foundation

class MockNetworkManager: NetworkManagerProtocol {
    var sendRequestResult: Result<APIResponse, NetworkManager.ApiError>?
    
    func sendHTTPRequest(urlString: String, mapToDataModel: Decodable.Type) async throws -> Result<APIResponse, NetworkManager.ApiError> {
        if let result = sendRequestResult {
            return result
        } else {
            fatalError("Mock not set up correctly")
        }
    }
}

