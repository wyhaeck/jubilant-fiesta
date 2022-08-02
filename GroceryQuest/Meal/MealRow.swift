//
//  MealRow.swift
//  GroceryQuest
//
//  Created by Will Haeck on 7/31/22.
//

import SwiftUI

struct MealRow: View {
    
    @ScaledMetric var imageWidth: CGFloat = 40
    
    let meal: Meal
    
    var body: some View {
        HStack {
            Label {
                VStack(alignment: .leading, spacing: 5) {
                    Text(meal.title)
                        .fontWeight(.bold)

                    Text(meal.date.formatted(date: .abbreviated, time: .shortened))
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            } icon: {
                Image(systemName: meal.symbol)
                    .foregroundStyle(meal.color)
                    .padding(.trailing, 15)
            }
            .labelStyle(CustomLabelStyle())
        }
        .badge(meal.remainingTaskCount - meal.containsEmptyTextCount)
        
        if meal.isComplete {
            Image(systemName: "checkmark")
                .foregroundStyle(.secondary)
        }
    }
}
