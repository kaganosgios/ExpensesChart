//
//  AuthView.swift
//  FireBaseExpense
//
//  Created by KağanKAPLAN on 5.12.2024.
//

import SwiftUI
import FirebaseAuth

struct AuthView: View {

    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isSignUp = false
    @State private var isShowError = false
    @State private var errorMessage = ""
    @State private var isLoggedIn = false

    
    var body: some View {
        
        if isLoggedIn{
            ExpensesView()
        }
        else{
            
            ZStack{
                //Color(hue: 0.333, saturation: 0.906, brightness: 0.453)
             VStack{
                
                HStack{
                    Text("Welcome Big Spender")
                        .font(.largeTitle)
                        .bold()
                    
                    
                    Text("$$$")
                        .bold()
                }
                
                
                
                Picker("", selection: $isSignUp){
                    Text("LogIn").tag(false)
                    Text("SignUp").tag(true)
                }
                .pickerStyle(.segmented)
                .padding()
                
                TextField("Email:", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                
                SecureField("Password:", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocorrectionDisabled()
                    .textContentType(.none)
                
                
                if isSignUp{
                    
                    SecureField("Confirm Password:", text: $confirmPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .autocorrectionDisabled()
                        .textContentType(.none)
                    
                }
                
                Button(isSignUp ? "  SignUp  " : " LogIn "){
                    isSignUp ? signUp() : login()
                    
                }.padding()
                
                    .background(Color(hue: 0.333, saturation: 0.906, brightness: 0.453))
                    .foregroundColor(.black)
                    .cornerRadius(18)
                
                if isShowError {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
                
            }
            .padding()
                               .background(Color.white)
                               .cornerRadius(16) // Rounded corners for the content container
                               .shadow(radius: 10)
        }
        .edgesIgnoringSafeArea(.all)
    }
        
    }
    
    
    func login(){
        Auth.auth().signIn(withEmail: email, password: password){ result , error in
            if let error = error{
                isShowError = true
                errorMessage = error.localizedDescription
            }else{
                //ana view
                isShowError = false
                                errorMessage = ""
                                isLoggedIn = true

            }
        }
        
    }
    func signUp(){
        
        guard password == confirmPassword else {
                   isShowError = true
                   errorMessage = "Passwords do not match."
                   return
               }
        Auth.auth().createUser(withEmail: email, password: password){ result , error in
            if let error = error{
                isShowError = true
                errorMessage = error.localizedDescription
            }else{
                //kayıt başarılı diğer ekrana siktirgit
                isShowError = false
                                errorMessage = ""
                                isLoggedIn = true
            }
            
        }
        
    }
    }
                                                                                                                                                               

#Preview {
    AuthView()
}
