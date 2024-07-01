//
//  MyActivitiesView.swift
//  keen_app
//
//  Created by Jennifer Tan on 4/29/24.
//

import Foundation
import SwiftUI

struct MyActivitiesView: View {
    @StateObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            Text("My activities")
                .font(.titleBold)
            ActivityList(viewModel: viewModel)
            Spacer()
        }
        .padding(.top, 15)
        .containerRelativeFrame([.horizontal, .vertical])
        .background(Color.backgroundGrey)
    }
}

struct ActivityList: View {
    @StateObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            ForEach(viewModel.activities) { activity in
                HStack {
                    ActivityEmoji(emoji: activity.emoji).body
                    Text(activity.name)
                        .font(.headlineBold)
                }
                .frame(width: 332, height: 87)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .shadow(color: Color(.systemGray4), radius: 4, x: 2, y: 3)
                    )
            }
        }
    }
}

// Handle missing emoji from db
struct ActivityEmoji: View {
    var emoji: String?
    var body: Text {
        if let emoji {
            return Text(emoji)
                .font(.system(size: 45))
        } else {
            return Text("❗️")
                .font(.system(size: 45))
        }
    }
}


#Preview {
    MyActivitiesView(viewModel: ProfileViewModel(userDetails: nil))
}
