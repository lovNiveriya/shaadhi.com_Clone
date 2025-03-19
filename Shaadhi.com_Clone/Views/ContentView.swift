//
//  ContentView.swift
//  Shaadhi.com_Clone
//
//  Created by LOVE  on 19/03/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: UserViewModel

    init(viewModel: UserViewModel) {
        self._viewModel = StateObject(wrappedValue: UserViewModel(userService: UserServiceIMPL(url: URL(string: "https://randomuser.me/api/?results=10")!)))
    }

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .onAppear(perform: {
            Task {
                await viewModel.loadUsers()
            }
        })
        .padding()
    }
}

#Preview {
    ContentView(viewModel: UserViewModel(userService: UserServiceIMPL(url: URL(string: "https://randomuser.me/api/?results=10")!)))
}
