//
//  SettingsItemModel.swift
//  keen_app
//
//  Created by Jennifer Tan on 4/21/24.
//

import Foundation
import SwiftUI

struct ProfileItem: Identifiable {
    var id = UUID()
    var settingsName: String
    var icon: Image!
}
