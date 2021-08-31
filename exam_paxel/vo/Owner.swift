//
//  Owner.swift
//  exam_paxel
//
//  Created by admin on 31/8/21.
//  Copyright © 2021 Aizid Dev. All rights reserved.
//

import Foundation

struct Owner: Decodable {
    let login: String?
    let id: Int?
    let nodeID: String?
    let avatar_url: String?
    let gravatarID: String?
    let url, htmlURL, followersURL: String?
    let followingURL, gistsURL, starredURL: String?
    let subscriptionsURL, organizationsURL, reposURL: String?
    let eventsURL: String?
    let receivedEventsURL: String?
    let type: String?
    let siteAdmin: Bool?
}
