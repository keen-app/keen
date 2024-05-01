//
//  ProfileView.swift
//  keen_app
//
//  Created by Jennifer Tan on 4/21/24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel: ProfileViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 35) {
                ProfileDetails(viewModel: viewModel)
                ProfileListView(viewModel: viewModel)
                Spacer()
            }
        }
        .foregroundColor(.black)
    }
}

struct ProfileDetails: View {
    @StateObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            ProfilePicture(image: viewModel.userDetails?.profilePicture, size: 100)
            Text("\(viewModel.userDetails!.firstName)")
                .font(.system(size: 24, weight: .semibold))
        }
        .padding(.top, 50)
    }
}

struct ProfileListView: View {
    @StateObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack {
            ForEach(viewModel.profileItems) { item in
                NavigationLink(
                    destination: MyActivitiesView(viewModel: viewModel)
                ) {
                    HStack {
                        item.icon
                            .frame(width: 40)
                        Text(item.settingsName)
                            .font(.system(size: 16, weight: .semibold))
                        Spacer()
                        Image(systemName: "chevron.right")
                            .frame(width: 40)
                    }
                    .frame(width: 342, height: 50)
                    .contentShape(Rectangle())
                }
                Divider()
                    .frame(width: 332)
            }
        }
    }
}

struct ProfilePicture: View {
    var image: Image?
    var size: CGFloat
    var body: some View {
        if let image {
            image
                .frame(width: size, height: size)
                .scaledToFit()
                .clipShape(Circle())
        } else {
            Color.blue
                .frame(width: size, height: size)
                .scaledToFit()
                .clipShape(Circle())
        }
    }
}

#Preview {
    ProfileView(viewModel: ProfileViewModel(userDetails: nil))
}
