//
//  GenerateMeals.swift
//  GroceryQuest
//
//  Created by Will Haeck on 7/31/22.
//

import SwiftUI

struct MealGenerator {
    @Binding var meal: Meal
    @State var weekdays = 7
    @EnvironmentObject var mealData: MealData

    @State private var mealCopy = Meal()

    var generateMeals: Array<Meal> {
        var generatedNums = [] as Array<Int>
        for num in 0..<(mealData.meals.capacity) {
            generatedNums.append(num)
        }
        var meals = [] as Array<Meal>
        var counter = 0
        while !generatedNums.isEmpty && counter < weekdays {
        // for num in 0..<(min(weekdays, generatedNums.capacity)) {
            let num = Int.random(in: 0..<generatedNums.capacity)
            meals.append(mealData.meals[num])
            meals.remove(at: num)
            counter += 1
        }
        
        return meals
    }
}
