import Foundation

class HourViewModel: ObservableObject, Identifiable {
    var id = UUID()
    var temp: String
    var hour: String
    var imageURL: String
    
    init(temp: String, hour: String, imageURL: String) {
        self.temp = temp
        self.hour = hour
        self.imageURL = imageURL
    }
}
