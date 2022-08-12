//
//  Titles.swift
//  1stCoreData
//
//  Created by 王杰 on 2022/8/12.
//

import Foundation

struct Titles: Codable {
    let results: [Title]
}

struct Title: Codable {
    let original_title: String?
}
