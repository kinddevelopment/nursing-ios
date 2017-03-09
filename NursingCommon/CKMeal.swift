//
//  CKMeal.swift
//  Nursing
//
//  Created by Markus Svensson on 2017-03-09.
//  Copyright © 2017 Markus Svensson. All rights reserved.
//

import CloudKit
import EVReflection

public class CKMeal: CKDataObject {
    var duration: Int = 0
    var start: Date = Date.init()
    var type: Int = MealType.leftBreast.rawValue
    
    init(meal: Meal) {
        super.init()
        
        self.duration = meal.duration
        self.start = meal.start.date
        self.type = meal.type.rawValue
    }
    
    required public init() {
        super.init()
        
        duration = 0
        start = Date.init()
        type = MealType.leftBreast.rawValue
    }
}
