//
//  Shaadhi_com_CloneApp.swift
//  Shaadhi.com_Clone
//
//  Created by LOVE  on 19/03/25.
//

import SwiftUI

@main
struct Shaadhi_com_CloneApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: UserViewModel(userService: UserServiceIMPL(url: URL(string: "https://randomuser.me/api/?results=10")!)))
        }
    }
}
