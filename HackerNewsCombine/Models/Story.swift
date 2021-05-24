//
//  Story.swift
//  HackerNewsCombine
//
//  Created by David Amunga on 24/05/2021.
//

import Foundation

struct Story:Codable {
    let id:Int
    let title:String
    let url:String
}

extension Story{
    static func placeholder()->Story{
        return Story(id: 0, title: "N/A", url: "")
    }
}
