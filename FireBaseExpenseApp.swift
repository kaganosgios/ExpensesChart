//
//  FireBaseExpenseApp.swift
//  FireBaseExpense
//
//  Created by KağanKAPLAN on 5.12.2024.
//

import SwiftUI
import Firebase

@main
struct FireBaseExpenseApp: App {
    init() {
            FirebaseApp.configure()
        }
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
