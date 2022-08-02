//
//  IngredientRow.swift
//  GroceryQuest
//
//  Created by Will Haeck on 7/30/22.
//

import SwiftUI

struct IngredientRow: View {
    @Binding var ingredient: MealIngredient
    var focusedTask: FocusState<MealIngredient?>.Binding

    var body: some View {
        HStack {
            Button {
                ingredient.isCompleted.toggle()
            } label: {
                Image(systemName: ingredient.isCompleted ? "checkmark.circle.fill" : "circle")
            }
            .buttonStyle(.plain)

            TextField("Ingredient Description", text: $ingredient.text)
                .focused(focusedTask, equals: ingredient)
            Spacer()
        }
    }
}
