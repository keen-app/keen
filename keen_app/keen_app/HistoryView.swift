//
//  MyActivitiesView.swift
//  keen_app
//
//  Created by Jennifer Tan on 4/29/24.
//

import Foundation
import SwiftUI

struct HistoryView: View {
    @StateObject var viewModel: ActivityViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 25) {
            Text("My activities")
                .font(.system(size: 20, weight: .bold))
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 30) {
                    ActivityGroup(
                        date: "14 April 2024",
                        activities: viewModel.activities
                    )
                    ActivityGroup(
                        date: "14 April 2024",
                        activities: viewModel.activities
                    )
                    ActivityGroup(
                        date: "14 April 2024",
                        activities: viewModel.activities
                    )
                }
            }
        }
        .padding(.top, 15)
        .containerRelativeFrame([.horizontal, .vertical])
        .background(Color(.systemGray6))
    }
}

struct ActivityGroup: View {
    var date: String
    var activities: [Activity]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(date)
                .font(.system(size: 14, weight: .semibold))
            ForEach(activities) { activity in
                ActivityView(emoji: activity.emoji, name: activity.name, friends: "Parth and Antriksh")
            }
        }
    }
}

struct ActivityView: View {
    var emoji: String
    var name: String
    var friends: String?
    
    var body: some View {
        HStack {
            HStack(spacing: 15) {
                Text(emoji)
                    .font(.system(size: 45))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(name)
                        .font(.system(size: 18, weight: .bold))
                    if let friends {
                        Text("with \(friends)")
                            .font(.system(size: 14))
                            .foregroundColor(.darkGray)
                    }
                }
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.darkGray)
                .font(.system(size: 20))
        }
        .frame(width: 300)
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(color: Color(.systemGray4), radius: 4, x: 2, y: 3)
            )
    }
}


#Preview {
    HistoryView(viewModel: ActivityViewModel())
}
