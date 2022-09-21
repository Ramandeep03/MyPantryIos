//
//  FirebaseRepository.swift
//  MyPantry
//
//  Created by Ramandeep Singh on 18/09/22.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class FirestoreRepository{
    private var db: Firestore
    
    init(){
        db = Firestore.firestore()
    }
    
    func add(item: Item, completion: @escaping (Result<Item?, Error>) -> Void) {
        do{
            let ref = try db.collection(Constants.pantry).addDocument(from: item)
            ref.getDocument { snapshot, error in
                guard let snapshot = snapshot, error == nil else{
                    completion(.failure(error ?? NSError(domain: "Snapshot is NIL", code: 101, userInfo: nil)))
                    return
                }
                
                let item = try? snapshot.data(as: Item.self)
                completion(.success(item))
            }
        }catch let error{
            completion(.failure(error))
        }
    }
    
    
    func getAllItems(completion: @escaping (Result<[Item]? , Error>) -> Void){
        db.collection(Constants.pantry)
            .getDocuments { snapshot, error in
                guard let snapshot = snapshot, error == nil else{
                    completion(.failure(error ?? NSError(domain: "Item get failes", code: 102, userInfo: nil)))
                    return
                }
                
                let items: [Item]? = snapshot.documents.compactMap { document in
                    var item = try? document.data(as: Item.self)
                    if item != nil{
                        item!.id = document.documentID
                    }
                    
                    return item
                }
                completion(.success(items))
            }
    }
    
    func update(item: Item , completion: @escaping (Result<Bool , Error>) -> Void){
        guard let itemId = item.id else{
            completion(.failure(NSError(domain: "Invalid id for item", code: 103, userInfo: nil)))
            return
        }
        
        do{
            try db.collection(Constants.pantry).document(itemId)
                .setData(from: item)
            completion(.success(true))
        }catch let error{
            completion(.failure(error))
        }
    }
    
    func getPantryCategories(completion: @escaping (Result<[Category]?, Error>) -> Void){
        db.collection(Constants.pantryCategory).getDocuments { snapshot, error in
            guard let snapshot = snapshot, error == nil else{
                completion(.failure(error ?? NSError(domain: "No Categories Found", code: 104, userInfo: nil)))
                return
            }
            
            let categories: [Category]? = snapshot.documents.compactMap { document in
                var category = try? document.data(as: Category.self)
                if category != nil {
                    category!.id = document.documentID
                }
                return category
            }
            completion(.success(categories))
        }
    }
    
    func delete(itemId: String, completion: @escaping (Error?) -> Void) {
        db.collection(Constants.pantry).document(itemId).delete{error in
            completion(error)
            
        }
    }
}


