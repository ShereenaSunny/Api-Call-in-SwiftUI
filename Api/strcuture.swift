//
//  strcuture.swift
//  Api
//
//  Created by Shereena Sunny on 10/04/22.
//

import Foundation

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}
