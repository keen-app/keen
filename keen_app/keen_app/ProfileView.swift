//
//  ProfileView.swift
//  keen_app
//
//  Created by Jennifer Tan on 4/21/24.
//

import SwiftUI

struct ProfileView: View {
    
    var viewModel = ProfileViewModel()
    
    var body: some View {
        ProfileListView(viewModel: ProfileViewModel())
    }
}

struct ProfileListView: View {
    var viewModel: ProfileViewModel
    
    var body: some View {
        VStack {
            ForEach(viewModel.profileItems) { item in
                HStack {
                    item.icon
                        .frame(width: 40)
                    Text(item.settingsName)
                        .font(.system(size: 16, weight: .semibold))
                    Spacer()
                    Image(systemName: "chevron.right")
                        .frame(width: 40)
                }
                .padding(.top, 10)
                .padding(.bottom, 10)
                .frame(width: 342)
                Divider()
                    .frame(width: 332)
            }
        }
    }
}

#Preview {
    ProfileView()
}
