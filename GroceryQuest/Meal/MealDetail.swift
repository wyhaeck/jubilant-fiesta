//
//  MealDetail.swift
//  GroceryQuest
//
//  Created by Will Haeck on 7/30/22.
//

import SwiftUI

struct MealDetail: View {
    @Binding var meal: Meal
    @Binding var isDeleted: Bool
    @Binding var isNew: Bool
    
    @EnvironmentObject var mealData: MealData
    @Environment(\.dismiss) private var dismiss
    
    @State private var isPickingSymbol = false
    
    @FocusState var focusedTask: MealIngredient?
    
    var body: some View {
        List {
            Section {
                HStack {
                    Button {
                        isPickingSymbol.toggle()
                    } label: {
                        Image(systemName: meal.symbol)
                            .imageScale(.large)
                            .foregroundColor(meal.color)
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal, 5)


                    TextField("New Meal", text: $meal.title)
                        .font(.title2)
         
                }
                .padding(.top, 5)
            
                DatePicker("Date", selection: $meal.date)
                    .labelsHidden()
                    .listRowSeparator(.hidden)

                Text("Ingredients")
                    .fontWeight(.bold)
                
                ForEach($meal.ingredients) { $item in
                    IngredientRow(ingredient: $item, focusedTask: $focusedTask)
                }

                .onDelete(perform: { indexSet in
                    meal.ingredients.remove(atOffsets: indexSet)
                })
                
                Button {
                    let newIngredient = MealIngredient(text: "", isNew: true)
                    meal.ingredients.append(newIngredient)
                    focusedTask = newIngredient
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add Ingredient")
                    }
                }
                .buttonStyle(.borderless)
            }
            
            if !isNew {
                Button(role: .destructive, action: {
                    isDeleted = true
                    dismiss()
                    mealData.delete(meal)
                }, label: {
                    Text("Delete Event")
                        .font(Font.custom("SF Pro", size: 17))
                        .foregroundColor(Color(UIColor.systemRed))
                })
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }

        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .sheet(isPresented: $isPickingSymbol) {
            SymbolPicker(meal: $meal)
        }
    }
}

