//
//  UserAuth.swift
//  swift_app
//
//  Created by 이동은 on 2021/04/15.
//

import Combine

class UserAuth: ObservableObject {
    @Published var isLoggedin:Bool = false

    func login() {
        self.isLoggedin = true
    }
    
    func logout() {
        self.isLoggedin = false
    }
}
