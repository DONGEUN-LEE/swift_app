//
//  LoginView.swift
//  swift_app
//
//  Created by 이동은 on 2021/04/15.
//

import SwiftUI
import ToastUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State private var presentingToast: Bool = false
    @EnvironmentObject var userAuth: UserAuth
    
    func login() {
        self.presentingToast = true;
        TokenManager.shared.deleteToken()
        let json: [String: Any] = ["email": self.email,
                                   "password": self.password]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let url = URL(string: "\(Constants.apiServerURL)/api/login")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let e = error {
                NSLog("An error has occerred: \(e.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async() {
                self.presentingToast = false
                do {
                    let object = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                    guard let jsonObject = object else { return }
                    
                    let token = jsonObject["token"] as? String
                    let message = jsonObject["message"] as? String
                    
                    if message == "Success" {
                        if TokenManager.shared.createToken(token!) {
                            self.userAuth.login()
                        }
                    }
                } catch let e as NSError {
                    print("An error has occured while parsing JSON Obejt : \(e.localizedDescription)")
                }
            }
        }
        
        task.resume()
    }
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .border(Color(UIColor.separator))
                .padding(.horizontal)
            SecureField("Password", text: $password)
                .border(Color(UIColor.separator))
                .padding(.horizontal)
            Button(action: login, label: {
                Text("Sign In")
            })
            .toast(isPresented: $presentingToast) {
                  ToastView("Loading...")
                      .toastViewStyle(IndefiniteProgressToastViewStyle())
            }
            
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .buttonStyle(DefaultButtonStyle())
    }
}
