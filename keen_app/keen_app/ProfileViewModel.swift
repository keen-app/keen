//
//  ProfileViewModel.swift
//  keen_app
//
//  Created by Jennifer Tan on 4/21/24.
//

import Foundation
import SwiftUI
import Combine

class ApiService {
    let baseUrl = "http://localhost:8080"
    
    func getUser(username: String) -> AnyPublisher<[User], Error> {
        let url = URL(string: "\(baseUrl)/user/\(username)")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [User].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getUserActivities(username: String) -> AnyPublisher<[Activity], Error> {
        let url = URL(string: "\(baseUrl)/events/\(username)")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Activity].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

class ProfileViewModel: ObservableObject {
    private let apiService: ApiService
    @Published var error: Error? = nil
    @Published var usersList: [User?] = []
    private var cancellables = Set<AnyCancellable>()
    // Dummy user and activity details as fallback
    @Published var activities: [Activity] = dummyActivitiesData
    @Published var userDetails: User? = dummyUserDetails
    let currentUsername = "alicej"  // Hardcode current user for now

    // Consolidated initializer
    init(apiService: ApiService = ApiService(), userDetails: User? = nil) {
        self.apiService = apiService
        addUserDetails(username: currentUsername)  // Get user details from db
        addActivities(username: currentUsername)  // Get user activities from db
    }
    
    // Function to add user activities
    func addActivities(username: String) {
        self.apiService.getUserActivities(username: username)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        self.error = error // Handle errors
                        print(error)
                    }
                },
                receiveValue: { response in
                    self.activities = response.compactMap{ $0 } // Remove nil values before storing
                }
            )
            .store(in: &cancellables) // Manage Combine subscriptions
    }
    
    // Function to fetch a specific user
    func addUserDetails(username: String) {
        self.apiService.getUser(username: username)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        self.error = error // Handle errors
                        print(error)
                    }
                },
                receiveValue: { response in
                    self.userDetails = response[0] // Store the fetched user details (there will only be one thing in the list)
                }
            )
            .store(in: &cancellables) // Manage Combine subscriptions
    }
    
}

let dummyActivitiesData = [
    Activity(name: "Kayaking", visibility: "private",
             startTime: "2024-09-05T10:00:00.000Z",
             endTime: "2024-09-05T18:00:00.000Z", emoji: "🛶"),
    Activity(name: "Pilates", visibility: "public",
             startTime: "2025-03-01T19:00:00.000Z",
             endTime: "2025-03-01T23:00:00.000Z", emoji: "🧘‍♀️"),
    Activity(name: "Escape room", visibility: "public",
             startTime: "2025-04-01T19:00:00.000Z",
             endTime: "2025-05-01T23:00:00.000Z", emoji: "🚪"),
]

let dummyUserDetails = User(email: "email", firstName: "firstName", lastName: "lastName", userName: "userName")
