//
//  MainView.swift
//  swift_app
//
//  Created by 이동은 on 2021/04/15.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var userAuth: UserAuth
    
    func logout() {
        if TokenManager.shared.deleteToken() {
            userAuth.logout()
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome!")
            }
            .navigationBarTitle(Text("Title"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: logout, label: {
                        Text("Sign Out")
                    })
                }
            }
        }
    }
}
