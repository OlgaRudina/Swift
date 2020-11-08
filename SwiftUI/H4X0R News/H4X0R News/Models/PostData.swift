//
//  PostData.swift
//  H4X0R News
//
//  Created by brandon on 2020-11-03.
//

import Foundation

struct Results: Decodable {
    let hits: [Post]
}


struct Post: Decodable, Identifiable {

    let points: Int
    let title: String
    let url: String?
    let objectID: String
    
    var id: String {
        return objectID
    }
    
}
