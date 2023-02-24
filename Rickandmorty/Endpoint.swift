import Foundation

var devHost = "https://rickandmortyapi.com/api"

var host = devHost

struct EndPoint {
    static let characters = URL(string: "\(host)/character")!
}
