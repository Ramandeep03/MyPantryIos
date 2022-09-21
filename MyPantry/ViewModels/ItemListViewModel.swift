//
//  ItemListViewModel.swift
//  MyPantry
//
//  Created by Ramandeep Singh on 21/09/22.
//

import Foundation


class ItemListViewModel: ObservableObject{
    
    private var  repo : FirestoreRepository
    
    @Published var item: [ItemViewModel] = []
    @Published var filterBy = ""
    
    init(){
        repo = FirestoreRepository()
    }
    
    
    func getAll(){
        repo.getAllItems { result in
            switch result{
            case .success(let fetchedItem):
                if let fetchedItem = fetchedItem {
                    DispatchQueue.main.async {
                        self.item = fetchedItem.map(ItemViewModel.init).filter({self.filterBy.isEmpty ? true : $0.categoryName == self.filterBy})
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func delete(itemId: String){
        repo.delete(itemId: itemId) { error in
            if error == nil {
                self.getAll()
                return
            }else{
                print(error?.localizedDescription ?? "")
            }
        }
    }
}
