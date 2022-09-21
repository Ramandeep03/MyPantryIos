//
//  AddItemView.swift
//  MyPantry
//
//  Created by Ramandeep Singh on 20/09/22.
//

import SwiftUI

struct AddItemView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var addItemViewModel = AddItemViewModel()
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Item Name", text: $addItemViewModel.name)
                    TextField("Qunatity", text: $addItemViewModel.quantity)
                    
                    
                    Picker(selection: $addItemViewModel.categoryName, label: Text("Category")) {
                        ForEach(addItemViewModel.cateegories, id:\.id){
                            Text($0.name).tag($0.name)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    
                    HStack{
                        Spacer()
                        Button("Save"){
                            addItemViewModel.add()
                        }.onChange(of: addItemViewModel.saved) { saved in
                            if saved{
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                        Spacer()
                    }
                }
            }
            .navigationTitle("Add new Item")
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
            }))
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}
