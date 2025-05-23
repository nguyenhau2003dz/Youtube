//
//  Video.swift
//  Youtube
//
//  Created by Hậu Nguyễn on 26/4/25.
//

import Foundation

struct Video: Decodable {
    var videoId = ""
    var title = ""
    var description = ""
    var thumbnail = ""
    var published = Date()

    enum CodingKeys: String, CodingKey {
        case snippet
        case thumbnails
        case high
        case resourceId
        case published = "publishedAt"
        case title
        case description
        case thumbnailUrl = "url"
        case videoId
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let snippetContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet) {
            self.title = try snippetContainer.decodeIfPresent(String.self, forKey: .title) ?? ""
            self.description = try snippetContainer.decodeIfPresent(String.self, forKey: .description) ?? ""
            
            if let publishedString = try? snippetContainer.decodeIfPresent(String.self, forKey: .published) {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
                if let date = formatter.date(from: publishedString) {
                    self.published = date
                }
            }
            
            if let thumbnailsContainer = try? snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnails),
               let highContainer = try? thumbnailsContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .high) {
                self.thumbnail = try highContainer.decodeIfPresent(String.self, forKey: .thumbnailUrl) ?? ""
            }
            
            if let resourceIdContainer = try? snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .resourceId) {
                self.videoId = try resourceIdContainer.decodeIfPresent(String.self, forKey: .videoId) ?? ""
            }
        }
    }
}
