//
//  AddItemViewModel.swift
//  MyPantry
//
//  Created by Ramandeep Singh on 20/09/22.
//

import Foundation


class AddItemViewModel: ObservableObject {
    private var repo: FirestoreRepository
    
    @Published var saved = false
    
    var name: String = ""
    var quantity: String = ""
    var categoryName: String = "Freezer"
    
    @Published var cateegories: [Category]  = []
    
    init(){
        repo = FirestoreRepository()
        repo.getPantryCategories { result in
            switch result{
            case .success(let cat):
                if let cat = cat {
                    DispatchQueue.main.async {
                        self.cateegories = cat
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func add(){
        let item = Item(name: name, qunatity: quantity, categoryName: categoryName)
        
        repo.add(item: item) { result in
            switch result {
            case .success(let item):
                DispatchQueue.main.async {
                    self.saved = item == nil ? false : true
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            
            }
        }
    }
    
}
