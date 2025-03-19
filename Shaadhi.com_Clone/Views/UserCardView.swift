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

    var body: some View {
        VStack {
            WebImage(url: URL(string: user.picture.large))
                .resizable()
                .indicator(.activity)
                .scaledToFill()
                .frame(height: 300)
                .clipped()
                .cornerRadius(10)
    
            Text("\(user.name.first) \(user.name.last)")
                .font(.title2)
                .fontWeight(.bold)

            Text("\(user.location.city), \(user.location.country)")
                .foregroundColor(.gray)

            HStack {
                Button(action: acceptAction) {
                    Text("Accept")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Button(action: declineAction) {
                    Text("Decline")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
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
