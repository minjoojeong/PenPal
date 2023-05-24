//
//  APIResults.swift
//  Pen Pal
//Decoding Google Books results
//  Created by min joo on 12/9/22.
//

import Foundation

struct APIResults: Decodable {
    var selfLink: String?
    var volumeInfo: VolumeInfo?
}

struct VolumeInfo: Decodable {
    var title: String?
    var subtitle: String?
    var authors: [String]?
    var publisher: String?
    var publishedDate: String?
    var description: String?
}
