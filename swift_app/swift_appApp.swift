//
//  swift_appApp.swift
//  swift_app
//
//  Created by 이동은 on 2021/04/10.
//

import SwiftUI

@main
struct swift_appApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(UserAuth())
        }
    }
}
