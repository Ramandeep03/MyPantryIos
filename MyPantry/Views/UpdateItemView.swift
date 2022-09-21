//
//  UpdateItemView.swift
//  MyPantry
//
//  Created by Ramandeep Singh on 21/09/22.
//

import SwiftUI

struct UpdateItemView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var updateItemViewModel: UpdateItemViewModel
    
    init(itemViewModel:ItemViewModel){
        _updateItemViewModel = StateObject<UpdateItemViewModel>.init(wrappedValue: UpdateItemViewModel(itemViewModel: itemViewModel))
    }
    var body: some View {
        Form{
            Section{
                TextField("Item Name", text: $updateItemViewModel.name )
                TextField("Quantity", text: $updateItemViewModel.qunatity )
                Picker(selection: $updateItemViewModel.categoryName, label: Text("Category")) {
                    ForEach(updateItemViewModel.categories, id:\.id){
                        Text($0.name).tag($0.name)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                HStack{
                    Spacer()
                    Button("Save"){
                        updateItemViewModel.update()
                    }.onChange(of: updateItemViewModel.saved) { itemSaved in
                        presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                }
            }
        }
        .navigationTitle("Update Item")
    }
}

struct UpdateItemView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateItemView(itemViewModel: ItemViewModel(item: Item(id:"ddadada",name: "Sample", qunatity: "12", categoryName: "Freezer")))
    }
}
