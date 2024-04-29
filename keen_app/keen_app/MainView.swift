//
//  NavigationBarView.swift
//  keen_app
//
//  Created by Jennifer Tan on 4/29/24.
//

import Foundation
import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ProfileView(viewModel: ProfileViewModel(userDetails: nil))
                .tabItem {
                    Label("Profile", systemImage: "star")
                }
            
            Text("Tab 2")
                .tabItem {
                    Label("Two", systemImage: "circle")
                }
        }
    }
}

#Preview {
    MainView()
}
