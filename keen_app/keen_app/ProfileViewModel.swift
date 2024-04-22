//
//  ProfileViewModel.swift
//  keen_app
//
//  Created by Jennifer Tan on 4/21/24.
//

import Foundation
import SwiftUI

class ProfileViewModel {
    var profileItems: [ProfileItem] = []
    
    init() {
        addProfileItems()
    }
    
    func addProfileItems() {
        profileItems = profileData
    }
        
}

let profileData = [
    ProfileItem(settingsName: "My activities", icon: Image(systemName: "list.bullet")),
    ProfileItem(settingsName: "Account settings", icon: Image(systemName: "gearshape.fill")),
    ProfileItem(settingsName: "Friends", icon: Image(systemName: "heart.fill"))
]
