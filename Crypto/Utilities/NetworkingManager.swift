//
//  NetworkingManager.swift
//  Crypto
//
//  Created by Agastya Nand on 17/04/25.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown

        var errorDescription: String? {
            switch self {
            case .badURLResponse(let url):
                return "[🔥] Bad response from URL: \(url)"
            case .unknown:
                return "[⚠️] Unknown error occurred"
            }
        }
    }

    static func download(url: URL, headers: [String: String]) -> AnyPublisher<Data, Error> {
        var request = URLRequest(url: url)
        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap {
                // 🧪 Debug: Print raw JSON
                let raw = String(data: $0.data, encoding: .utf8) ?? "nil"
                print("📩 Raw response from \(url):\n\(raw)")
                return try handleURLResponse(output: $0, url: url)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }

    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("❌ Network error: \(error.localizedDescription)")
        }
    }
}
