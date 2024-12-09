//
//  ExpensesView.swift
//  FireBaseExpense
//
//  Created by KağanKAPLAN on 7.12.2024.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct ExpensesView: View {
    @State private var expenses: [ExpensesSecond] = []
    @State private var totalExpenses : Double = 0.0
    @State private var categoryData: [(String, Double)] = []
    
    @State private var showAddExpenseView = false
    @State private var showAuthView = false
    
    
    let db = Firestore.firestore()
    
    
    var body: some View {
        VStack{
            Text("Total spend: \(totalExpenses, specifier: "%.2f")₺")
                .font(.caption)
                .bold()
                .padding()
            
            if !categoryData.isEmpty {
                ExpenseCategoryChartView(categoryData: categoryData)
            } else {
                Text("Kategori verisi yükleniyor...")
            }
            
            List(expenses) { expense in
                HStack{
                    Image(systemName: iconForCategory(expense.category))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.blue)
                    
                    
                    VStack(alignment: .leading){
                        Text(expense.name)
                            .font(.headline)
                        Text(expense.date, style: .date)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                    }
                    Spacer()
                    
                    Text("\(expense.amount, specifier: "%.2f")₺")
                        .font(.body)
                        .foregroundColor(.gray)
                    
                    
                }
            }
            
            
            HStack {
                Button(action: {
                    logOut()
                }) {
                    Image(systemName: "arrow.backward.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                        .foregroundColor(.red)
                }
                .padding()
                
                Spacer()
                
                Button(action: {
                    showAddExpenseView = true
                }) {
                    Text("+")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .frame(width: 60, height: 60)
                        .background(Color.green)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                }
                .frame(alignment: .center)
                .padding()
                Spacer()
                Spacer()
            }
            
            
            
            
            
        }.onAppear {
            fetchExpenses()
        }
        
        
        .sheet(isPresented: $showAddExpenseView) {
                    AddExpenseView()
                }
                .fullScreenCover(isPresented: $showAuthView) {
                    AuthView()
                }
       
    }
        
    
    
    
    
    func logOut(){
        do {
                    try Auth.auth().signOut()
                    showAuthView = true
                } catch {
                    print("Error signing out: \(error.localizedDescription)")
                }
    }
    
    func iconForCategory(_ category: String) -> String{
        switch category{
        case "Food" : return "fork.knife.circle"
        case "Car-Bus" : return "car.circle"
        case "Ticket" : return "ticket"
        case "Coffee" : return "cup.and.saucer"
        case "Clothes" : return "tshirt.circle"
        case "Sport" : return "figure.gymnastics.circle"
        case "Gifts" : return "gift.circle"
        default: return "questionmark.circle"
        }
        
    }
    func fetchExpenses() {
        db.collection("expenses").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching expenses: \(error)")
            } else {
                expenses = snapshot?.documents.compactMap { document in
                    let data = document.data()
                    let category = data["category"] as? String ?? "Diğer"
                    let name = data["name"] as? String ?? "Bilinmiyor"
                    let amount = data["amount"] as? Double ?? 0.0
                    let timestamp = data["date"] as? Timestamp ?? Timestamp(date: Date())
                    let date = timestamp.dateValue()
                    
                    return ExpensesSecond(id: document.documentID, category: category, name: name, amount: amount, date: date)
                } ?? []
                
                totalExpenses = expenses.reduce(0) { $0 + $1.amount }
                
                categoryData = calculateCategoryTotals()
            }
        }
    }
    func calculateCategoryTotals() -> [(String, Double)] {
        var categoryTotals: [String: Double] = [:]
        
        for expense in expenses {
            categoryTotals[expense.category, default: 0.0] += expense.amount
        }
        
        return categoryTotals.map { ($0.key, $0.value) }
    }
}
    
    



#Preview {
    ExpensesView()
}
//["Food","Car-Bus","Ticket","Coffee","Clothes","Spor","Gifts"]
