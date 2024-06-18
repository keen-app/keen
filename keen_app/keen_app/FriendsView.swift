//
//  FriendsView.swift
//  keen_app
//
//  Created by Jennifer Tan on 6/18/24.
//

import SwiftUI

struct FriendsView: View {
    @Environment(\.presentationMode) var presentation
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            HeaderView(
                icon: "chevron.left",
                iconAction: { presentation.wrappedValue.dismiss() },
                heading: "Friends"
            )
            ScrollView {
                // TODO: Add Friends page content
            }
        }
        .padding(.top, 15)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6))
        .navigationBarBackButtonHidden(true)
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}
