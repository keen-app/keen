//
//  MyActivitiesModel.swift
//  keen_app
//
//  Created by Jennifer Tan on 4/29/24.
//

import Foundation
import SwiftUI

struct Activity: Codable, Identifiable {
    var id = UUID()
    var name, visibility, startTime, endTime: String
    var emoji, location, url, description: String?
    enum CodingKeys: String, CodingKey {
        case name
        case visibility
        case startTime = "start"
        case endTime = "end"
        case emoji
        case location
        case url
        case description
    }
}
