//
//  MealData.swift
//  GroceryQuest
//
//  Created by Will Haeck on 7/30/22.
//

import SwiftUI

class MealData: ObservableObject {
    @Published var meals: [Meal] = [
        Meal(
//            symbol: "gift.fill",
              color: .red,
              title: "Maya's Birthday",
             ingredients: [MealIngredient(text: "Guava kombucha"),
                      MealIngredient(text: "Paper cups and plates"),
                      MealIngredient(text: "Cheese plate"),
                      MealIngredient(text: "Party poppers"),
                     ],
              date: Date.roundedHoursFromNow(60 * 60 * 24 * 30)),
        Meal(symbol: "theatermasks.fill",
              color: .yellow,
              title: "Pagliacci",
             ingredients: [MealIngredient(text: "Buy new tux"),
                      MealIngredient(text: "Get tickets"),
                      MealIngredient(text: "Book a flight for Carmen"),
                     ],
              date: Date.roundedHoursFromNow(60 * 60 * 22)),
        Meal(symbol: "facemask.fill",
              color: .indigo,
              title: "Health Check-up",
             ingredients: [MealIngredient(text: "Bring medical ID"),
                      MealIngredient(text: "Record heart rate data"),
                     ],
              date: Date.roundedHoursFromNow(60 * 60 * 24 * 4)),
        Meal(symbol: "leaf.fill",
              color: .green,
              title: "Camping Trip",
             ingredients: [MealIngredient(text: "Find a sleeping bag"),
                      MealIngredient(text: "Bug spray"),
                      MealIngredient(text: "Paper towels"),
                      MealIngredient(text: "Food for 4 meals"),
                      MealIngredient(text: "Straw hat"),
                     ],
              date: Date.roundedHoursFromNow(60 * 60 * 36)),
        Meal(symbol: "gamecontroller.fill",
              color: .cyan,
              title: "Game Night",
             ingredients: [MealIngredient(text: "Find a board game to bring"),
                      MealIngredient(text: "Bring a dessert to share"),
                     ],
              date: Date.roundedHoursFromNow(60 * 60 * 24 * 2)),
        Meal(symbol: "graduationcap.fill",
              color: .primary,
              title: "First Day of School",
             ingredients: [
                MealIngredient(text: "Notebooks"),
                MealIngredient(text: "Pencils"),
                MealIngredient(text: "Binder"),
                MealIngredient(text: "First day of school outfit"),
              ],
              date: Date.roundedHoursFromNow(60 * 60 * 24 * 365)),
        Meal(symbol: "book.fill",
              color: .purple,
              title: "Book Launch",
             ingredients: [
                MealIngredient(text: "Finish first draft"),
                MealIngredient(text: "Send draft to editor"),
                MealIngredient(text: "Final read-through"),
              ],
              date: Date.roundedHoursFromNow(60 * 60 * 24 * 365 * 2)),
        Meal(symbol: "globe.americas.fill",
              color: .gray,
              title: "WWDC",
             ingredients: [
                MealIngredient(text: "Watch Keynote"),
                MealIngredient(text: "Watch What's new in SwiftUI"),
                MealIngredient(text: "Go to DT developer labs"),
                MealIngredient(text: "Learn about Create ML"),
              ],
              date: Date.from(month: 6, day: 7, year: 2021)),
        Meal(symbol: "case.fill",
              color: .orange,
              title: "Sayulita Trip",
             ingredients: [
                MealIngredient(text: "Buy plane tickets"),
                MealIngredient(text: "Get a new bathing suit"),
                MealIngredient(text: "Find a hotel room"),
              ],
              date: Date.roundedHoursFromNow(60 * 60 * 24 * 19)),
    ]
    
    func delete(_ meal: Meal) {
        meals.removeAll { $0.id == meal.id }
    }
    
    func add(_ meal: Meal) {
        meals.append(meal)
    }
    
    func exists(_ meal: Meal) -> Bool {
        meals.contains(meal)
    }
    
    func sortedMeals(period: Period) -> Binding<[Meal]> {
        Binding<[Meal]>(
            get: {
                self.meals
                    .filter {
                        switch period {
                        case .nextSevenDays:
                            return $0.isWithinSevenDays
                        case .nextThirtyDays:
                            return $0.isWithinSevenToThirtyDays
                        case .future:
                            return $0.isDistant
                        case .past:
                            return $0.isPast
                        }
                    }
                    .sorted { $0.date < $1.date }
            },
            set: { meals in
                for meal in meals {
                    if let index = self.meals.firstIndex(where: { $0.id == meal.id }) {
                        self.meals[index] = meal
                    }
                }
            }
        )
    }
}

enum Period: String, CaseIterable, Identifiable {
    case nextSevenDays = "Next 7 Days"
    case nextThirtyDays = "Next 30 Days"
    case future = "Future"
    case past = "Past"
    
    var id: String { self.rawValue }
    var name: String { self.rawValue }
}

extension Date {
    static func from(month: Int, day: Int, year: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        let calendar = Calendar(identifier: .gregorian)
        if let date = calendar.date(from: dateComponents) {
            return date
        } else {
            return Date.now
        }
    }

    static func roundedHoursFromNow(_ hours: Double) -> Date {
        let exactDate = Date(timeIntervalSinceNow: hours)
        guard let hourRange = Calendar.current.dateInterval(of: .hour, for: exactDate) else {
            return exactDate
        }
        return hourRange.end
    }
}
