//
//  ItemViewModel.swift
//  MyPantry
//
//  Created by Ramandeep Singh on 21/09/22.
//

import Foundation

struct ItemViewModel{
    let item: Item
    
    var id: String{
        item.id ?? ""
    }
    
    var name: String {
        item.name
    }
    
    var quantity: String {
        item.qunatity
    }
    
    var categoryName: String {
        item.categoryName
    }
}
