//
//  UserCardView.swift
//  Shaadhi.com_Clone
//
//  Created by LOVE  on 20/03/25.
//
import SwiftUI
import SDWebImageSwiftUI

struct UserCardView: View {
    @State var user: User
    var updateUserStatus: (User) -> Void

    @State private var offset: CGFloat = 0
    @State private var opacity: Double = 1.0

    var body: some View {
        ZStack(alignment: .bottom) {
            imageView
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 16) {
                userInfo
                userStatusView
            }
            .padding()
        }
        .cornerRadius(16)
        .shadow(radius: 5)
        .offset(x: offset)
        .opacity(opacity)
        .animation(.easeInOut(duration: 0.5), value: offset)
    }

    private var imageView: some View {
        WebImage(url: URL(string: user.picture.large))
            .resizable()
            .indicator(.activity)
            .aspectRatio(contentMode: .fit)
            .overlay(
                LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.7)]),
                               startPoint: .center,
                               endPoint: .bottom)
            )
    }

    private var userInfo: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(user.name.first + " " + user.name.last)
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                
                Image(systemName: "checkmark.seal.fill") // Verified badge
                    .foregroundColor(.blue)
            }
            
            Text("\(user.dob.age) yrs • Engineer")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
            
            Text("\(user.location.country)")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
        }
        .padding(.horizontal, 10)
    }

    @ViewBuilder
    private var userStatusView: some View {
        if user.selectionState == SelectionState.none || user.selectionState == nil {
            buttonStackView
        } else {
            selectedStateView
        }
    }

    private var buttonStackView: some View {
        HStack {
            Button(action: {
                handleSelection(.rejected)
            }) {
                Circle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 60, height: 60)
                    .overlay(Image(systemName: "xmark")
                                .foregroundColor(.white)
                                .font(.title2))
            }
            
            Spacer()
            
            Button(action: {
                handleSelection(.accepted)
            }) {
                Circle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]),
                                         startPoint: .topLeading,
                                         endPoint: .bottomTrailing))
                    .frame(width: 60, height: 60)
                    .overlay(Image(systemName: "checkmark")
                                .foregroundColor(.white)
                                .font(.title2))
            }
        }
        .padding(.horizontal, 8)
    }

    private var selectedStateView: some View {
        Text(user.selectionState == .accepted ? "Accepted ✅" : "Rejected ❌")
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(user.selectionState == .accepted ? .green : .red)
            .padding()
            .background(Color.white.opacity(0.8))
            .cornerRadius(12)
            .transition(.scale)
            .animation(.spring(), value: user.selectionState)
    }

    private func handleSelection(_ state: SelectionState) {
        if user.selectionState == state { return }
        user.selectionState = state

        withAnimation(.easeInOut(duration: 0.5)) {
            offset = state == .accepted ? 300 : (state == .rejected ? -300 : 0)
            opacity = 0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            user.isSelected = (state == .accepted)
            updateUserStatus(user)

            withAnimation(.easeInOut(duration: 0.3)) {
                offset = 0
                opacity = 1.0
            }
        }
    }
}

#Preview {
    UserCardView(
        user: User.mockUser,
        updateUserStatus: { updatedUser in
            print("User status updated: \(updatedUser.isSelected ?? false ? "Accepted" : "Rejected")")
        }
    )
}
