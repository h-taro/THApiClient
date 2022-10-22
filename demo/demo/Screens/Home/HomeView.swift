//
//  HomeView.swift
//  demo
//
//  Created by 平石　太郎 on 2022/10/22.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        contentView
            .onAppear(perform: viewModel.onAppear)
    }
    
    private var contentView: some View {
        usersView
    }
    
    private var usersView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 16) {
                ForEach(viewModel.users) { userView($0) }
            }
            .padding(.horizontal)
        }
    }
    
    private func userView(_ user: UserResponse) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(user.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text(user.username)
                .font(.body)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
        .padding(.vertical)
        .padding(.leading)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.pink.opacity(0.6))
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
