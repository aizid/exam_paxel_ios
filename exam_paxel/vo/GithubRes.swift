//
//  GithubRes.swift
//  exam_paxel
//
//  Created by admin on 31/8/21.
//  Copyright © 2021 Aizid Dev. All rights reserved.
//

import Foundation

struct GithubRes: Decodable {
    let totalCount: Int?
    let incompleteResults: Bool?
    let items: [Item]
}
