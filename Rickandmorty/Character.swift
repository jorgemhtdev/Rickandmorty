import Foundation

struct Info:Decodable {
    let info: InfoClass
    let results: [Result]
}

struct InfoClass:Decodable {
    let count, pages: Int
    let next: String
    let prev: String?
}

struct Result:Identifiable, Hashable, Decodable {
    let id: Int
    let name: String
    let status: Status
    let species: String
    let gender: Gender
    let origin, location: Location
    let image: String
    let url: String
    
    private enum CodingKeys: String, CodingKey {
        case id, name, status, species, gender, origin, location, image, url
    }
}

// The gender of the character ('Female', 'Male', 'Genderless' or 'unknown').
enum Gender:String, Decodable {
    case female = "Female"
    case male = "Male"
    case genderless = "genderless"
    case unknown = "unknown"
    
    enum CodingKeys: String, CodingKey {
        case female = "female"
        case male = "male"
        case genderless = "genderless"
        case unknown = "unknown"
    }
}

struct Location:Identifiable, Hashable, Decodable {
    var id = UUID()
    let name: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case url = "url"
    }
}

// The status of the character ('Alive', 'Dead' or 'unknown').
enum Status:String, Decodable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
    
    enum CodingKeys: String, CodingKey {
        case alive = "alive"
        case dead = "dead"
        case unknown = "unknown"
    }
}
