//
//  SearchResult.swift
//  Pen Pal
//
//  Created by min joo on 12/4/22.
//

import Foundation

struct SearchResult: Decodable {
    let items: [APIResults]
    
    enum CodingKeys: String, CodingKey {
        case items
    }
}

//used Throwable because I kept messing up
extension SearchResult {
  
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let throwables = try values.decode([Throwable<APIResults>].self, forKey: .items)
        items = throwables.compactMap { try? $0.result.get() }
    }
}
