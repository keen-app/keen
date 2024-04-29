//
//  MyActivitiesModel.swift
//  keen_app
//
//  Created by Jennifer Tan on 4/29/24.
//

import Foundation

import SwiftUI

struct Activity: Identifiable {
    var id = UUID()
    var name: String
    var emoji: String
}
