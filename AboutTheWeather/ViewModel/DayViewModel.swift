import Foundation

struct DayViewModel: Identifiable {
    let id = UUID()
    let day: String
    let high: String
    let low: String
}
