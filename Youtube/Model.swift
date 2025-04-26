//
//  Model.swift
//  Youtube
//
//  Created by Hậu Nguyễn on 26/4/25.
//

import Foundation

class Model {
    func getVideos() {
        guard let url = URL(string: Constants.URL_API) else {
            print("Url is error")
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil || data == nil {
                print("Error when get data")
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let response = try decoder.decode(Response.self, from: data!)
                print(response)
            } catch {
                print("Error switch JSON to Object")
            }
        }
        task.resume()
    }
}
