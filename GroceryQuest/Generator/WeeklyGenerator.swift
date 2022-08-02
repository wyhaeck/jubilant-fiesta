//
//  WeeklyGenerator.swift
//  GroceryQuest
//
//  Created by Will Haeck on 7/31/22.
//

import SwiftUI

struct WeeklyGenerator: View {
    @State var weekdays = 7
    @StateObject private var mealData = MealData()

    var generateMeals: Array<Meal> {
        var generatedNums = [] as Array<Int>
        for num in 0..<(mealData.meals.capacity) {
            generatedNums.append(num)
        }
        var mealed = [] as Array<Meal>
        var counter = 0
        var cap = generatedNums.count
        while !generatedNums.isEmpty && counter < weekdays {
            let num = Int.random(in: 0..<cap)
            mealed.append(mealData.meals[generatedNums[num]])
            generatedNums.remove(at: num)
            counter += 1
            cap -= 1
        }
        
        return mealed
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(generateMeals) { meal in
                    HStack {
                        Text(meal.title)
                        ForEach(meal.ingredients) { ingredient in
                            Text(ingredient.text)
                        }
                    }
                }
            }
        }
    }
}
