//
//  ProfileModel.swift
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

struct User: Identifiable {
    var id = UUID()
    var firstName: String
    var lastName: String
    var profilePicture: Image?
}
