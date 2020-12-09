//
//  Lorem.swift
//  LoremPicsumHW
//
//  Created by Field Employee on 12/8/20.
//

import Foundation

struct Lorem: Decodable {
    let id: String
    let loremImageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case download_url
    }
    
//    enum URLCodingKeys: String, CodingKey {
//        case url
//    }
    
    init(from decoder: Decoder) throws {
        let container = try
            decoder.container(keyedBy: CodingKeys.self)
        let container2 = try
            decoder.container(keyedBy: CodingKeys.self)
//        let urlContainer = try
//            container.nestedContainer(keyedBy: URLCodingKeys.self, forKey: .url)
        self.id = try container.decode(String.self, forKey: .id)
        self.loremImageURL = try
            container2.decode(URL.self, forKey: .download_url)
    }
}
