//
//  ProfileView.swift
//  TwitterClone
//
//  Created by Ozgun Efe on 30/06/2024.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    @State private var selectedFilter: TweetFilterViewModel = .tweets
    @Environment(\.presentationMode) var mode
    @Namespace var animation
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
    var body: some View {
        VStack(alignment: .leading){
            headerView
            
            actionButtons
            
            userInfoDetails
        
            tweetFilterBar
            
            tweetsView
            
            Spacer()
        }
        .navigationBarHidden(true)
    }
}

extension ProfileView {
    
    var headerView: some View {
        ZStack(alignment: .bottomLeading){
            Color(.systemBlue)
                .ignoresSafeArea()
            
            VStack {
                Button {
                    // Bu kod geldigimiz sayfaya bizi geri donduruyor bir nevi geri tusu. Bunu kullanabilrmek icin yukarida "@Environment(\.presentationMode) var mode" kodunu kullandik.
                    mode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 20, height: 16)
                        .foregroundColor(.white)
                        .offset(x: 13, y: 8)
                }
                .padding(.bottom, 10)

                KFImage(URL(string: user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 72, height: 72)
                    .offset(x:16, y:24)
            }
        }
        .frame(height: 96)
    }
    
    var actionButtons: some View{
        HStack(spacing: 12){
            Spacer()
            
            Image(systemName: "bell.badge")
                .font(.title3)
                .padding(6)
                .overlay(Circle().stroke(Color.gray, lineWidth: 0.75))
            
            Button {
                //code
            } label: {
                Text("Edit Profile")
                    .font(.subheadline).bold()
                    .frame(width: 120, height: 32)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 0.75))
                    .foregroundColor(.black)
                    
            }

        }
        .padding(.trailing)
        .padding(.top, 5)
    }
    
    var userInfoDetails: some View{
        VStack(alignment: .leading, spacing: 4){
            HStack {
                Text(user.fullname)
                    .font(.title2).bold()
                
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(Color(.systemBlue))
            }
            Text("@\(user.username)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text("iOS Developer")
                .font(.subheadline)
                .padding(.vertical)
            
            HStack(spacing: 20){
                HStack(spacing: 6){
                    Image(systemName: "mappin.and.ellipse")

                    Text("London, UK")
                }
                
                HStack(spacing: 5){
                    Image(systemName: "link")

                    Text("ozgunefe.com")
                }
            }
            .font(.caption)
            .foregroundColor(.gray)
            
            UserStatsView()
                .padding(.vertical)
            
        }
        .padding(.horizontal)
    }
    
    var tweetFilterBar: some View {
        HStack{
            ForEach(TweetFilterViewModel.allCases, id: \.rawValue) { item in
                VStack{
                    Text(item.title)
                        .font(.subheadline)
                        // Bu kod ile secili kismi kontrol ediyoruz. Secili kismi semibold digerlerini regular gosteriyoruz.
                        .fontWeight(selectedFilter == item ? .semibold : .regular)
                        .foregroundStyle(selectedFilter == item ? .black : .gray)
                    
                    // Buradaki Capsule ile asagidaki mavi rengi veriyoruz ve if ile kontrol ediyoruz. Bu sekilde sadece secili olan item mavi renge sahip oluyor.
                    if selectedFilter == item {
                        Capsule()
                            .foregroundColor(Color(.systemBlue))
                            .frame(height: 3)
                            // matchedGeometryEffect ile mavi capsulun animasyonunu yaptik. Mavi kapsul tikladigimiz yere kayiyor.
                            // Bunun icin yukarida "@Namespace var animation" tanimladik.
                            .matchedGeometryEffect(id: "filter", in: animation)
                    } else {
                        Capsule()
                            .foregroundColor(Color(.clear))
                            .frame(height: 3)
                    }
                    
                }
                // Bu kod tiklanabilirlik ve opsiyonlar arasi gecis sagliyor.
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.selectedFilter = item
                    }
                }
            }
        }
        .overlay(Divider().offset(x:0, y:16))
    }
    
    var tweetsView: some View {
        ScrollView {
            LazyVStack{
                ForEach(0 ... 10, id: \.self) { _ in
//                        TweetRowView()

                }
            }
        }
    }
}


#Preview {
    ProfileView(user: User(id: NSUUID().uuidString, 
                           username: "batman",
                           fullname: "Bruce Wayne",
                           profileImageUrl: "",
                           email: "batman@gmail.com"))
}
