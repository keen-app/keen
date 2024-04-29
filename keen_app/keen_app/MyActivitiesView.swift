//
//  MyActivitiesView.swift
//  keen_app
//
//  Created by Jennifer Tan on 4/29/24.
//

import Foundation
import SwiftUI

struct MyActivitiesView: View {
    @StateObject var viewModel: MyActivitiesViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            Text("My activities")
                .font(.system(size: 20, weight: .bold))
            ActivityList(viewModel: viewModel)
            Spacer()
        }
        .padding(.top, 15)
        .containerRelativeFrame([.horizontal, .vertical])
        .background(Color(.systemGray6))
    }
}

struct ActivityList: View {
    var viewModel: MyActivitiesViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            ForEach(viewModel.activities) { activity in
                HStack {
                    Text(activity.emoji)
                        .font(.system(size: 45))
                    Text(activity.name)
                        .font(.system(size: 18, weight: .bold))
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


#Preview {
    MyActivitiesView(viewModel: MyActivitiesViewModel())
}
