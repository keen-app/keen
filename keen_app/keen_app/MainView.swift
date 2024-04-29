//
//  MainView.swift
//  keen_app
//
//  Created by Jennifer Tan on 4/29/24.
//

import Foundation
import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                }
            AddActivityView()
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                }
            ProfileView(viewModel: ProfileViewModel(userDetails: nil))
                .tabItem {
                    Image(systemName: "person.fill")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
