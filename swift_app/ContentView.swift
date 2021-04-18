//
//  ContentView.swift
//  swift_app
//
//  Created by 이동은 on 2021/04/10.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userAuth: UserAuth
    
    var body: some View {
        VStack{
            if !userAuth.isLoggedin {
                LoginView()
            } else {
                MainView()
            }
        }
        .onAppear {
            let token = TokenManager.shared.readToken()
            if token != nil {
                userAuth.login()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
