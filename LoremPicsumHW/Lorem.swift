//
//  Lorem.swift
//  LoremPicsumHW
//
//  Created by Field Employee on 12/8/20.
//

import Foundation

struct Lorem: Decodable {
    let name: String
   // let types: String
    let frontImageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case name
        case sprites
        case types
    }
    
    enum URLCodingKeys: String, CodingKey {
        case front = "front_default"
        case type
    }
    
//    enum speciesCodingKeys: String, CodingKey {
//        case speciesName = "0"
//    }
    
    init(from decoder: Decoder) throws {
        let container = try
            decoder.container(keyedBy: CodingKeys.self)
//        let container2 = try
//            decoder.container(keyedBy: CodingKeys.self)
        let urlContainer = try
            container.nestedContainer(keyedBy: URLCodingKeys.self, forKey: .sprites)
//        let speciesContainer = try
//            container.nestedContainer(keyedBy: speciesCodingKeys.self, forKey: .types)
        self.name = try container.decode(String.self, forKey: .name)
        //self.types = try speciesContainer.decode(String.self, forKey: .speciesName)
        self.frontImageURL = try
            urlContainer.decode(URL.self, forKey: .front)
    }
}
