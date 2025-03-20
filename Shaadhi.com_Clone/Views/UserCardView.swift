//
//  UserCardView.swift
//  Shaadhi.com_Clone
//
//  Created by LOVE  on 20/03/25.
//
import SwiftUI
import SDWebImageSwiftUI

struct UserCardView: View {
    let user: User
    var acceptAction: () -> Void
    var declineAction: () -> Void
    
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
    
    private var buttonStackView: some View {
        HStack {
            VStack {
                Button(action: declineAction) {
                    Circle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 60, height: 60)
                        .overlay(Image(systemName: "xmark").foregroundColor(.white).font(.title2))
                }
                Text("Not Now")
                    .foregroundColor(.white)
                    .font(.footnote)
            }
            
            Spacer()
            
            VStack {
                Button(action: acceptAction) {
                    Circle()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]),
                                             startPoint: .topLeading,
                                             endPoint: .bottomTrailing))
                        .frame(width: 60, height: 60)
                        .overlay(Image(systemName: "checkmark").foregroundColor(.white).font(.title2))
                }
                Text("Connect")
                    .foregroundColor(.white)
                    .font(.footnote)
            }
        }
        .padding(.horizontal, 8)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            imageView
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 16) {
                userInfo
                buttonStackView
            }
            .padding()
        }
        
        .cornerRadius(16)
        .shadow(radius: 5)
    }
    
}

#Preview {
    UserCardView(
        user: User.mockUser,
        acceptAction: { print("Accepted") },
        declineAction: { print("Declined") }
    )
}
