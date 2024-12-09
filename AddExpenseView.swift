//
//  AddExpenseView.swift
//  FireBaseExpense
//
//  Created by KağanKAPLAN on 6.12.2024.
//

import SwiftUI
import FirebaseFirestore

struct AddExpenseView: View {
    @State private var category = "Food"
    @State private var name = ""
    @State private var amount = ""
    @State private var date = Date()
    
    let categories = ["Food","Car-Bus","Ticket","Coffee","Clothes","Sport","Gifts"]
    let db = Firestore.firestore()
    
    @Environment(\.dismiss) var dismiss  



    @available(iOS 17.0, *)
    var body: some View {
        
        
        NavigationView{
            ZStack{
                Color(Color(hue: 1.0, saturation: 0.0, brightness: 0.972))
                    .edgesIgnoringSafeArea(.all)
            
            VStack{
                
                
                
                Form{
                    Picker("Category", selection: $category){
                        ForEach(categories, id: \.self){ Text($0)
                            
                        }
                    }
                    DatePicker("Date", selection: $date , displayedComponents: .date)
                    //.padding()
                    TextField("Name", text: $name)
                        .padding()
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                        .padding()
    
                }
                .frame(maxWidth: .infinity, maxHeight: 280)
                .padding(.top)
                
                Button {
                    addExpense()
                } label: {
                    Text("Add")
                        .font(.title)
                        .fontWeight(.bold)
                }
                .frame(maxWidth: 90, maxHeight: 60)
                .background(Color(hue: 0.333, saturation: 0.906, brightness: 0.453))
                .foregroundColor(.white)
                .cornerRadius(10)
      
                
            }
            
            
        }
        }
        .navigationTitle("I Just Spent This")
    }
    
    
    func addExpense(){
        guard let amountDouble = Double(amount) else { return }
        
        db.collection("expenses").addDocument(data:[
                        "category": category,
                        "name": name,
                        "amount": amountDouble,
                        "date": Timestamp(date: date)
        ]){
            error in
            if let  error = error{
                print("error adding data")
            }else{
               dismiss()
                print("adding data success")
            }
        }

        
    }
}

#Preview {
    AddExpenseView()
}
