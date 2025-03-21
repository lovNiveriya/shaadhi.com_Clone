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
    @State private var offset: CGFloat = 0
    @State private var opacity: Double = 1.0

    var updateUserStatus: (User) -> Void

    var body: some View {
        ZStack(alignment: .bottom) {
            imageView
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: Constants.padding) {
                userInfo
                userStatusView
            }
            .padding()
        }
        .cornerRadius(Constants.cornerRadius)
        .shadow(radius: Constants.shadowRadius)
        .offset(x: offset)
        .opacity(opacity)
        .animation(.easeInOut(duration: Constants.animationDuration), value: offset)
    }

    private var imageView: some View {
        WebImage(url: URL(string: user.picture.large))
            .resizable()
            .indicator(.activity)
            .aspectRatio(contentMode: .fit)
            .overlay(Constants.overlayGradient)
    }

    private var userInfo: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("\(user.name.first) \(user.name.last)")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(.blue)
            }
            
            Text("\(user.dob.age) yrs • Engineer")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
            
            Text(user.location.country)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
        }
        .padding(.horizontal, Constants.horizontalPadding)
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
                    .frame(width: Constants.buttonSize, height: Constants.buttonSize)
                    .overlay(
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .font(Constants.buttonIconFontSize)
                    )
            }
            
            Spacer()
            
            Button(action: {
                handleSelection(.accepted)
            }) {
                Circle()
                    .fill(Constants.buttonGradient)
                    .frame(width: Constants.buttonSize, height: Constants.buttonSize)
                    .overlay(
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)
                            .font(Constants.buttonIconFontSize)
                    )
            }
        }
        .padding(.horizontal, Constants.buttonSpacing)
    }

    private var selectedStateView: some View {
        Text(user.selectionState == .accepted ? Constants.acceptedText : Constants.rejectedText)
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(user.selectionState == .accepted ? Constants.acceptedColor : Constants.rejectedColor)
            .padding()
            .background(Color.white.opacity(0.8))
            .cornerRadius(12)
            .transition(.scale)
            .animation(.spring(), value: user.selectionState)
    }

    private func handleSelection(_ state: SelectionState) {
        if user.selectionState == state { return }
        user.selectionState = state

        withAnimation(.easeInOut(duration: Constants.animationDuration)) {
            offset = state == .accepted ? 300 : (state == .rejected ? -300 : 0)
            opacity = 0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.animationDuration) {
            updateUserStatus(user)

            withAnimation(.easeInOut(duration: 0.3)) {
                offset = 0
                opacity = 1.0
            }
        }
    }
    private struct Constants {
            static let cornerRadius: CGFloat = 16
            static let shadowRadius: CGFloat = 5
            static let animationDuration: Double = 0.5
            static let padding: CGFloat = 16
            static let horizontalPadding: CGFloat = 10
            static let buttonSize: CGFloat = 60
            static let buttonIconFontSize: Font = .title2
            static let buttonSpacing: CGFloat = 8
            static let acceptedText = "Accepted ✅"
            static let rejectedText = "Rejected ❌"
            static let acceptedColor = Color.green
            static let rejectedColor = Color.red
            static let overlayGradient = LinearGradient(
                gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.7)]),
                startPoint: .center,
                endPoint: .bottom
            )
            static let buttonGradient = LinearGradient(
                gradient: Gradient(colors: [Color.green, Color.blue]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
    }
}

#Preview {
    UserCardView(
        user: User.mockUser,
        updateUserStatus: { updatedUser in }
    )
}
