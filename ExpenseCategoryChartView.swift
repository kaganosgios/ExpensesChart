//
//  ExpenseCategoryChartView.swift
//  FireBaseExpense
//
//  Created by KağanKAPLAN on 9.12.2024.
//

import SwiftUI
import Charts

struct ExpenseCategoryChartView: View {
    var categoryData: [(String, Double)]
      
      var body: some View {
          Chart {
              ForEach(categoryData, id: \.0) { category, amount in
                  SectorMark(
                      angle: .value("Amount", amount),
                      innerRadius: .ratio(0.5),
                      outerRadius: .ratio(1.0)
                  )
                  .foregroundStyle(by: .value("Category", category))
              }
          }
          .chartLegend(.visible)
          .chartForegroundStyleScale([
              "Car-Bus": .blue,
              "Food": .green,
              "Ticket": .orange,
              "Coffee": .brown,
              "Clothes": .purple,
              "Sport": .pink,
              "Gifts": .yellow
          ])
          .frame(height: 300)
      }
}

#Preview {
    ExpenseCategoryChartView(categoryData: [("test", 31)])
}
