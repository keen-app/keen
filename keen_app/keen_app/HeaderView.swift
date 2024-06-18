//
//  HeaderView.swift
//  keen_app
//
//  Created by Jennifer Tan on 6/18/24.
//

import SwiftUI

struct HeaderView: View {
    var icon: String
    var iconAction: (() -> Void)
    var heading: String
    
    var body: some View {
        HStack {
            Button(
                action: iconAction,
                label: {
                    Image(systemName: icon)
                        .foregroundColor(.black)
                        .font(.system(size: 20))
                }
            )
            Spacer()
            Text(heading)
                .font(.system(size: 20, weight: .bold))
            Spacer()
        }
        .frame(width: 332)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(icon: "chevron.left", iconAction: { print("Test") }, heading: "Heading")
    }
}

