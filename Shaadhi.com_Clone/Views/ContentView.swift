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
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.users, id: \.id) { user in
                        UserCardView(
                            user: user,
                            acceptAction: { viewModel.acceptUser(user) },
                            declineAction: { viewModel.declineUser(user) }
                        )
                    }
                }
                .padding(16)
            }
            .navigationTitle("MatchMate")
            .alert("Error", isPresented: $viewModel.showAlert, actions: {
                Button("OK", role: .cancel) { }
            }, message: {
                Text(viewModel.errorMessage ?? "An unexpected error occurred.")
            })
        }
        .onAppear(perform: {
            Task {
                await viewModel.loadUsers()
            }
        })
    }
}

#Preview {
    ContentView(viewModel: UserViewModel(userService: UserServiceIMPL(url: URL(string: "https://randomuser.me/api/?results=10")!)))
}
