//
//  Meal.swift
//  Nursing
//
//  Created by Markus Svensson on 2017-03-09.
//  Copyright © 2017 Markus Svensson. All rights reserved.
//

import Foundation
import SwiftMoment

public enum MealType: Int {
    case leftBreast = 0
    case rightBreast = 1
    case formula = 2
}

/**
 Represents a meal/breatfeeding session.
 */
public class Meal {
    public var duration = 0
    public var type = MealType.leftBreast
    public var start = moment()
    
    public init() {
        self.duration = 0
        self.type = .leftBreast
        self.start = moment()
    }
    
    public init(duration: Int, type: MealType, start: Moment) {
        self.duration = duration
        self.type = type
        self.start = start
    }
    
    init(daoMeal: CKMeal) {
        self.duration = daoMeal.duration
        
        if let uwType = MealType.init(rawValue: daoMeal.type) {
            self.type = uwType
        }
        else {
            KDLog("WARNING: Type couldn't be converted from the CKMeal object.")
        }
        
        self.start = moment(daoMeal.start)
    }
}
