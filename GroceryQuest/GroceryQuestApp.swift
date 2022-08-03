//
//  GroceryQuestApp.swift
//  GroceryQuest
//
//  Created by Will Haeck on 7/11/22.
//

import SwiftUI
import SQLite

@main
struct MealPlannerApp: App {
    @StateObject private var mealData = MealData()
    @State private var showGenerateMeals = false

    var body: some Scene {
        WindowGroup {
            NavigationView {
                MealList()
                //showGenerateMeals ? (
                WeeklyGenerator()
//                ) : (
//                    Button("Select a Meal") {
//                        showGenerateMeals.toggle()
//                    }
//                )
            }
            .environmentObject(mealData)
        }
    }
}
