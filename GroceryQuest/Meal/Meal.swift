//
//  Meal.swift
//  GroceryQuest
//
//  Created by Will Haeck on 7/30/22.
//

import SwiftUI

struct Meal: Identifiable, Hashable {
    var id = UUID()
    var symbol: String = "circle.fill" // MealSymbols.randomName()
    var color: Color = ColorOptions.random()
    var title = ""
    var ingredients = [MealIngredient(text: "")]
    var date = Date.now
    var type = ""
    
    var containsEmptyTextCount: Int {
        ingredients.filter { $0.text.isEmpty }.count
    }
    
    var remainingTaskCount: Int {
        ingredients.filter { !$0.isCompleted }.count
    }
    
    var isComplete: Bool {
        ingredients.allSatisfy { $0.isCompleted }
    }
    
    var isPast: Bool {
        date < Date.now
    }
    
    var isWithinSevenDays: Bool {
        !isPast && date < Date.now.sevenDaysOut
    }
    
    var isWithinSevenToThirtyDays: Bool {
        !isPast && !isWithinSevenDays && date < Date.now.thirtyDaysOut
    }
    
    var isDistant: Bool {
        date >= Date().thirtyDaysOut
    }

}

// Convenience methods for dates.
extension Date {
    var sevenDaysOut: Date {
        Calendar.autoupdatingCurrent.date(byAdding: .day, value: 7, to: self) ?? self
    }
    
    var thirtyDaysOut: Date {
        Calendar.autoupdatingCurrent.date(byAdding: .day, value: 30, to: self) ?? self
    }
}
