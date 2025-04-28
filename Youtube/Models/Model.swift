//
//  Model.swift
//  Youtube
//
//  Created by Hậu Nguyễn on 26/4/25.
//

import Foundation

protocol ModelDelegate: AnyObject {
    func didFetchVideos(_ videos: [Video]?)
    func didFailWithError(_ error: Error)
}

class Model {
    weak var delegate: ModelDelegate?

    func getVideos() {
        guard let url = URL(string: Constants.URL_API) else {
            print("URL is invalid")
            return
        }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                self?.delegate?.didFailWithError(error)
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let response = try decoder.decode(Response.self, from: data)
                self?.delegate?.didFetchVideos(response.items)
            } catch {
                self?.delegate?.didFailWithError(error)
            }
        }
        task.resume()
    }
}
