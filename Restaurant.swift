//
//  Restaurant.swift
//  FoodPin
//
//  Created by Ikhsan on 29/8/17.
//  Copyright © 2017 Ikhsan. All rights reserved.
//

import Foundation


class Restaurant{
    
    var name = ""
    var type = ""
    var location = ""
    var image = ""
    var isVisited = false
    var rating = ""
    
    init(name: String, type: String, location: String, image: String, isVisited: Bool) {
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.isVisited = isVisited
    }
    
}
