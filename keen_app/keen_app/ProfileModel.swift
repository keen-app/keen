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

struct User: Codable, Identifiable {
    var id = UUID()
    var email: String
    var firstName: String
    var lastName: String
    var userName: String
    var profilePicture: Image?
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case firstName = "first_name"
        case lastName = "last_name"
        case userName = "username"
    }
}
