import Foundation

struct Info: Codable {
    let info: InfoClass
    let results: [Result]
}

struct InfoClass: Codable {
    let count, pages: Int
    let next: String
    let prev: String?
}

struct Result: Codable {
    let id: Int
    let name: String
    let status: Status
    let species: String
    let type: String
    let gender: Gender
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

// The gender of the character ('Female', 'Male', 'Genderless' or 'unknown').
enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case genderless = "genderless"
    case unknown = "unknown"
}

struct Location: Codable {
    let name: String
    let url: String
}

// The status of the character ('Alive', 'Dead' or 'unknown').
enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
