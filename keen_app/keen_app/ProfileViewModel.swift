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

    func getAllUsers() -> AnyPublisher<[User], Error> {
        let url = URL(string: "\(baseUrl)/users")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
//            .map { data, response in
//                // Print the raw data in a readable format
//                if let jsonString = String(data: data, encoding: .utf8) {
//                    print("Raw JSON data:\n\(jsonString)")
//                } else {
//                    print("Failed to convert data to String")
//                }
//                return data
//            }
            .decode(type: [User].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    
    func getUser(username: String) -> AnyPublisher<[User], Error> {
        let url = URL(string: "\(baseUrl)/user/\(username)")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [User].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

class ProfileViewModel: ObservableObject {
    private let apiService: ApiService
    @Published var error: Error? = nil // Default to nil
    @Published var usersList: [User?] = [] // Default to nil
    private var cancellables = Set<AnyCancellable>() // Empty set
    @Published var profileItems: [ProfileItem] = [] // Empty array

    // Dummy user data as fallback
    @Published var userDetails: User? = User(email: "email", firstName: "firstName", lastName: "lastName", userName: "userName");

    // Consolidated initializer
    init(apiService: ApiService = ApiService(), userDetails: User? = nil) {
        self.apiService = apiService
        addProfileItems() // Initialize profileItems with predefined data
        getAllUserDetails() // Fetch user list from the API
        getUserDetails(username: "alicej")  // Hardcode one user from the db for now
    }

    // Function to add profile items
    func addProfileItems() {
        profileItems = profileData // Assuming profileData is predefined elsewhere
    }

    // Function to fetch user list
    func getAllUserDetails() {
        self.apiService.getAllUsers() // Assuming `getUsers` is a method in `ApiService`
            .receive(on: DispatchQueue.main) // Ensure UI updates on the main thread
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        self.error = error // Handle errors
                        print(error)
                    }
                },
                receiveValue: { response in
                    self.usersList = response // Store the fetched user list
                }
            )
            .store(in: &cancellables) // Manage Combine subscriptions
    }
    
    func getUserDetails(username: String) {
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
                    self.userDetails = response[0] // Store the fetched user details
                }
            )
            .store(in: &cancellables) // Manage Combine subscriptions
    }
    
}

let profileData = [
    ProfileItem(settingsName: "My activities", icon: Image(systemName: "list.bullet")),
    ProfileItem(settingsName: "Account settings", icon: Image(systemName: "gearshape.fill")),
    ProfileItem(settingsName: "Friends", icon: Image(systemName: "heart.fill"))
]
