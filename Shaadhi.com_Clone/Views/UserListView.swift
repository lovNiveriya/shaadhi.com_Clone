//
//  ContentView.swift
//  Shaadhi.com_Clone
//
//  Created by LOVE  on 19/03/25.
//

import SwiftUI

struct UserListView: View {
    @StateObject var viewModel: UserViewModel

    init() {
        if let url = URL(string: Constants.apiURLString) {
            _viewModel = StateObject(wrappedValue: UserViewModel(userService: UserServiceIMPL(url: url)))
        } else {
            fatalError("Invalid URL string: \(Constants.apiURLString)")
        }
    }

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: Constants.cardSpacing) {
                    ForEach(viewModel.users, id: \.id) { user in
                        UserCardView(user: user) { user in
                            viewModel.handelUserSelectionAction(user, selectionState: user.selectionState)
                        }
                    }
                }
                .padding(Constants.padding)
            }
            .navigationTitle(Constants.navigationTitle)
            .alert(Constants.alertTitle, isPresented: $viewModel.showAlert, actions: {
                Button(Constants.alertButtonTitle, role: .cancel) { }
            }, message: {
                Text(viewModel.errorMessage ?? Constants.alertDefaultMessage)
            })
        }
        .onAppear {
            Task {
                await viewModel.loadUsers()
            }
        }
    }
}

struct Constants {
    static let apiURLString = "https://randomuser.me/api/?results=10"
    static let navigationTitle = "MatchMate"
    static let padding: CGFloat = 16.0
    static let cardSpacing: CGFloat = 16.0
    static let alertTitle = "Error"
    static let alertButtonTitle = "OK"
    static let alertDefaultMessage = "An unexpected error occurred."
}

#Preview {
    UserListView()
}
