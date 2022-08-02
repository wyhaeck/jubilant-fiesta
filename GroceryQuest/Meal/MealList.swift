//
//  MealList.swift
//  GroceryQuest
//
//  Created by Will Haeck on 7/30/22.
//

import SwiftUI

struct MealList: View {
    @EnvironmentObject var mealData: MealData
    @State private var isAddingNewMeal = false
    @State private var newMeal = Meal()
    
    var body: some View {
        List {
            NavigationLink {
                WeeklyGenerator()
            } label: {
                Text("Generate Random Meals")
            }
            ForEach(Period.allCases) { period in
                if !mealData.sortedMeals(period: period).isEmpty {
                    Section(content: {
                        ForEach(mealData.sortedMeals(period: period)) { $meal in
                            NavigationLink {
                                MealEditor(meal: $meal)
                            } label: {
                                MealRow(meal: meal)
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    mealData.delete(meal)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }, header: {
                        Text(period.name)
                            .font(.callout)
                            .foregroundColor(.secondary)
                            .fontWeight(.bold)
                    })
                }
            }
        }
        .navigationTitle("Meal Planner")
        .toolbar {
            ToolbarItem {
                Button {
                    newMeal = Meal()
                    isAddingNewMeal = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isAddingNewMeal) {
            NavigationView {
                MealEditor(meal: $newMeal, isNew: true)
            }
        }
    }
}

struct MealList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MealList().environmentObject(MealData())

        }
    }
}
