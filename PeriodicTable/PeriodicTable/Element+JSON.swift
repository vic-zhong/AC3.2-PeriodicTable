//
//  Element+JSON.swift
//  PeriodicTable
//
//  Created by Victor Zhong on 12/21/16.
//  Copyright © 2016 Victor Zhong. All rights reserved.
//

import Foundation

extension Element {
   func populate(from elementDict:[String:Any]) {
        
        guard let number = elementDict["number"] as? Int,
            let group = elementDict["group"] as? Int,
            let weight = elementDict["weight"] as? Double,
            let name = elementDict["name"] as? String,
            let symbol = elementDict["symbol"] as? String else { return }
            self.group = Int64(group)
            self.weight = weight
            self.name = name
            self.symbol = symbol
            self.number = Int64(number)
        
    }
}

