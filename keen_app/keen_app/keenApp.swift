//
//  keenApp.swift
//  keen_app
//
//  Created by Jennifer Tan on 4/21/24.
//

import SwiftUI

@main
struct keenApp: App {
    var body: some Scene {
        WindowGroup {
            ProfileView(viewModel: ProfileViewModel(userDetails: nil))
        }
    }
}
