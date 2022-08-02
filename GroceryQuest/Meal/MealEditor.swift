//
//  MealEditor.swift
//  GroceryQuest
//
//  Created by Will Haeck on 7/30/22.
//

import SwiftUI

struct MealEditor: View {
    @Binding var meal: Meal
    @State var isNew = false
    
    @State private var isDeleted = false
    @EnvironmentObject var mealData: MealData
    @Environment(\.dismiss) private var dismiss
    
    @State private var mealCopy = Meal()
    
    private var isMealDeleted: Bool {
        !mealData.exists(mealCopy) && !isNew
    }
    
    var body: some View {
        VStack {
            MealDetail(meal: $mealCopy, isDeleted: $isDeleted, isNew: $isNew)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        if isNew {
                            Button("Cancel") {
                                dismiss()
                            }
                        }
                    }
                    ToolbarItem {
                        Button {
                            if isNew {
                                mealData.meals.append(mealCopy)
                                dismiss()
                            }
                        } label: {
                            Text(isNew ? "Add" : "")
                        }
                        .disabled(mealCopy.title.isEmpty)
                    }
                }
                .onAppear {
                    mealCopy = meal
                }
                .onChange(of: mealCopy){ _ in
                    if !isDeleted {
                        meal = mealCopy
                    }
                }
        }
        .overlay(alignment: .center) {
            if isMealDeleted {
                Color(UIColor.systemBackground)
                Text("Meal Deleted. Select a Meal.")
                    .foregroundStyle(.secondary)
            }
        }
    }
}

struct MealEditor_Previews: PreviewProvider {
    static var previews: some View {
        MealEditor(meal: .constant(Meal()), isNew: true)
            .environmentObject(MealData())
    }
}

