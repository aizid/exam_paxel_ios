//
//  License.swift
//  exam_paxel
//
//  Created by admin on 31/8/21.
//  Copyright © 2021 Aizid Dev. All rights reserved.
//

import Foundation

struct License: Decodable {
    let key, name, spdxID: String?
    let url: String?
    let nodeID: String?
}
