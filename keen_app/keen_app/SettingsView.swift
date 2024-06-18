//
//  SettingsView.swift
//  keen_app
//
//  Created by Jennifer Tan on 6/18/24.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentation
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            HeaderView(
                icon: "chevron.left",
                iconAction: { presentation.wrappedValue.dismiss() },
                heading: "Settings"
            )
            ScrollView {
                // TODO: Add Settings page content
            }
        }
        .padding(.top, 15)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6))
        .navigationBarBackButtonHidden(true)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
