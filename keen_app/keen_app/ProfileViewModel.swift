//
//  ProfileViewModel.swift
//  keen_app
//
//  Created by Jennifer Tan on 4/21/24.
//

import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject {
    var profileItems: [ProfileItem] = []
    @Published var userDetails: User? // Change user details to be non-optional when onboarding is set up (https://github.com/keen-app/keen/issues/6)
    // Set a user dummy data
    let dummyUser = User(firstName: "John", lastName: "Doe")
    
    init(userDetails: User?) {
        addProfileItems()
        addUserDetails(userDetails)
    }
    
    func addProfileItems() {
        profileItems = profileData
    }
    
    func addUserDetails(_ userDetails: User?) {
        self.userDetails = userDetails ?? dummyUser
    }
    
}

let profileData = [
    ProfileItem(settingsName: "My activities", icon: Image(systemName: "list.bullet")),
    ProfileItem(settingsName: "Account settings", icon: Image(systemName: "gearshape.fill")),
    ProfileItem(settingsName: "Friends", icon: Image(systemName: "heart.fill"))
]
