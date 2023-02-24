import Foundation
import Combine

private let json = "application/json"
private let headerType = "Content-Type"
private let headerField = "Accept"

private var cancellables = Set<AnyCancellable>()

func get<T: Decodable>(url: URL, type: T.Type, onSuccess: @escaping (T) -> Void, onFailure: @escaping (Error) -> Void) {
    
    guard let getUrl = URLComponents(url: url, resolvingAgainstBaseURL: false), let urlFinal = getUrl.url else {
        return
    }
    
    var request = URLRequest(url: urlFinal)
    request.addValue(json, forHTTPHeaderField: headerType)
    request.addValue(json, forHTTPHeaderField: headerField)
    request.httpMethod = "GET"

    URLSession.shared
        .dataTaskPublisher(for: url)
        .map { $0.data }
        .decode(type: T.self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    onFailure(error)
                }
            },
            receiveValue: { onSuccess($0) }
        )
        .store(in: &cancellables)
}
