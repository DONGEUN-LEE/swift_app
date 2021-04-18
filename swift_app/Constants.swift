//
//  Constants.swift
//  swift_app
//
//  Created by 이동은 on 2021/04/18.
//

import Foundation

struct Constants {
    static var apiServerURL: String {
        (Bundle.main.infoDictionary?["API_SERVER_URL"] as? String) ?? ""
    }
}
