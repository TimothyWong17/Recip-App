//
//  RecipeModel.swift
//  Recipe List App (iOS)
//
//  Created by Timothy Wong on 7/7/22.
//

import Foundation

class RecipeModel: ObservableObject {
    
    @Published var recipes = [Recipe]()
    
    
    init(){
        self.recipes = DataService.getLocalData()
    }
    
    static func getPortion(ingredient: Ingredient, recipeServings: Int, targetServings: Int ) ->String {
        var portion = ""
        var numerator = ingredient.num ?? 1
        var denominator = ingredient.denom ?? 1
        var wholePoritions = 0
        
        if ingredient.num != nil {
            denominator *= recipeServings
            
            numerator *= targetServings
            
            let divisor = Rational.greatestCommonDivisor(numerator, denominator)
            numerator /= divisor
            denominator /= divisor
            
            
            if numerator >= denominator {
                wholePoritions = numerator / denominator
                numerator %= denominator
                
                portion += String(wholePoritions)
            }
            
            if numerator > 0 {
                portion += wholePoritions > 0 ? " " : ""
                portion += "\(numerator)/\(denominator)"
            }
            
            if var unit = ingredient.unit {
                
                if wholePoritions > 1 {
                    if unit.suffix(2) == "ch" {
                        unit += "es"
                    } else if unit.suffix(1) == "f"{
                        unit = String(unit.dropLast())
                        unit += "ves"
                        
                        
                    }else {
                        unit += "s"
                    }
                }

                
                portion += ingredient.num == nil && ingredient.denom == nil ? "" : " "
                return portion + unit
            }
            
        }
        return portion
    }
    
}
