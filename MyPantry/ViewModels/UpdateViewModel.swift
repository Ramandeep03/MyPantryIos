//
//  UpdateViewModel.swift
//  MyPantry
//
//  Created by Ramandeep Singh on 21/09/22.
//

import Foundation

class UpdateItemViewModel:ObservableObject{
    private var repo: FirestoreRepository
    
    @Published var saved = false
    @Published var categories: [Category] = []
    var id: String
    var name: String
    var qunatity: String
    var categoryName: String
    
    
    init(itemViewModel: ItemViewModel) {
        repo = FirestoreRepository()
        
        id = itemViewModel.id
    name = itemViewModel.name
        qunatity = itemViewModel.quantity
        categoryName = itemViewModel.categoryName
        
        repo.getPantryCategories { result in
            switch result{
            case .success(let cat):
                if let cat = cat {
                    DispatchQueue.main.async {
                        self.categories = cat
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func update(){
        let item = Item(id: id, name: name, qunatity: qunatity, categoryName: categoryName)
        
        repo.update(item: item) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.saved = success
                }
            case .failure(let error):
                print(error)
            
            }
        }
    }
}
