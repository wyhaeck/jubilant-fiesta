//
//  MealIngredient.swift
//  GroceryQuest
//
//  Created by Will Haeck on 7/30/22.
//

import Foundation

struct MealIngredient: Identifiable, Hashable {
    var id = UUID()
    var text: String
    var isCompleted = false
    var isNew = false
}
