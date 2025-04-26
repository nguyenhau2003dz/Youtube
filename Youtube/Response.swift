//
//  Response.swift
//  Youtube
//
//  Created by Hậu Nguyễn on 26/4/25.
//

import Foundation

struct Response: Decodable {
    var items: [Video]?
    enum CodingKeys: String, CodingKey {
        case items
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.items = try container.decode([Video].self, forKey: .items)
    }
}
