//
//  ProfileViewModel.swift
//  keen_app
//
//  Created by Jennifer Tan on 4/21/24.
//

import Foundation
import SwiftUI
import Combine
import Alamofire

class ApiService {
    static let sharedInstance = ApiService()
    typealias CompletionHandler<T: Codable> = (Result<[T], Error>) -> Void
    
    let baseUrl = "http://localhost:8080"
    
    func getUser<T: Codable>(username: String, completion: @escaping CompletionHandler<T>) {
        let url = URL(string: "\(baseUrl)/user/\(username)")!
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil)
            .response{ resp in
                switch resp.result{
                case .success(let data):
                    do{
                        let jsonData = try JSONDecoder().decode([T].self, from: data!)
                        print(jsonData)
                        completion(.success(jsonData))
                    } catch {
                        print(error.localizedDescription)
                        completion(.failure(error))
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
    }
    
    func getUserActivities<T: Codable>(username: String, completion: @escaping CompletionHandler<T>) {
        let url = URL(string: "\(baseUrl)/events/\(username)")!
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil)
            .response{ resp in
                switch resp.result{
                case .success(let data):
                    do{
                        let jsonData = try JSONDecoder().decode([T].self, from: data!)
                        print("Activities: \(jsonData)")
                        completion(.success(jsonData))
                    } catch {
                        print("Activities Error 1: \(error.localizedDescription)")
                        completion(.failure(error))
                    }
                case .failure(let error):
                    print("Activities Error 2: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
    }
    
}

class ProfileViewModel: ObservableObject {
    private let apiService: ApiService
//    @Published var error: Error? = nil
    @Published var error: String? = nil
    @Published var usersList: [User?] = []
    private var cancellables = Set<AnyCancellable>()
    @Published var profileItems: [ProfileItem] = []
    // Dummy user and activity details as fallback
    @Published var activities: [Activity] = dummyActivitiesData
    @Published var userDetails: User? = dummyUserDetails
    let currentUsername = "alicej"  // Hardcode current user for now

    // Consolidated initializer
    init(apiService: ApiService = ApiService(), userDetails: User? = nil) {
        self.apiService = apiService
        addProfileItems()
        addUserDetails(username: currentUsername)  // Get user details from db
        addActivities(username: currentUsername)  // Get user activities from db
    }

    // Function to add profile items
    func addProfileItems() {
        profileItems = profileData
    }
    
    // Function to add user activities
    func addActivities(username: String) {
        ApiService.sharedInstance.getUserActivities(username: username) { [weak self] (result: Result<[Activity], Error>) in
            switch result {
            case .success(let activities):
                DispatchQueue.main.async {
                    self?.activities = activities
                    self?.error = nil
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.error = error.localizedDescription
                }
            }
        }
    }
    
    // Function to fetch a specific user
    func addUserDetails(username: String) {
        ApiService.sharedInstance.getUser(username: username) { [weak self] (result: Result<[User], Error>) in
            switch result {
            case .success(let users):
                DispatchQueue.main.async {
                    self?.userDetails = users[0]
                    self?.error = nil
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.error = error.localizedDescription
                }
            }
        }
    }
    
}

let profileData = [
    ProfileItem(settingsName: "My activities", icon: Image(systemName: "list.bullet")),
    ProfileItem(settingsName: "Account settings", icon: Image(systemName: "gearshape.fill")),
    ProfileItem(settingsName: "Friends", icon: Image(systemName: "heart.fill"))
]

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
