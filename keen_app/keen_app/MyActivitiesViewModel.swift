//
//  MyActivitiesViewModel.swift
//  keen_app
//
//  Created by Jennifer Tan on 4/29/24.
//

import Foundation
import SwiftUI

class MyActivitiesViewModel: ObservableObject {
    @Published var activities: [Activity] = []
    
    init() {
        addActivities()
    }
    
    func addActivities() {
        activities = dummyActivitiesData
    }
    
}

let dummyActivitiesData = [
    Activity(name: "Kayaking", emoji: "🛶"),
    Activity(name: "Pilates", emoji: "🧘‍♀️"),
    Activity(name: "Escape room", emoji: "🚪"),
]
