//
//  RootView.swift
//  FireBaseExpense
//
//  Created by KağanKAPLAN on 9.12.2024.
//

import SwiftUI
import FirebaseAuth

struct RootView: View {
    @State private var isLoggedIn: Bool = false
        
        var body: some View {
            Group {
                if isLoggedIn {
                    ExpensesView() // Kullanıcı giriş yaptıysa ana ekran
                } else {
                    AuthView() // Kullanıcı giriş yapmadıysa giriş ekranı
                }
            }
            .onAppear {
                checkAuthStatus()
            }
        }
        
        private func checkAuthStatus() {
            let currentUser = Auth.auth().currentUser
            isLoggedIn = (currentUser != nil) // Kullanıcı giriş yaptıysa true
        }}

#Preview {
    RootView()
}
