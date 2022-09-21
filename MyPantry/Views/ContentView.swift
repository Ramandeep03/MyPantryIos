//
//  ContentView.swift
//  MyPantry
//
//  Created by Ramandeep Singh on 18/09/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isPresented = false
    
    @ObservedObject private var itemListViewModel = ItemListViewModel()
 
    var body: some View {
        NavigationView  {
            ZStack(alignment: .bottomTrailing){
                List{
                    ForEach(itemListViewModel.item, id: \.id){ item in
                        NavigationLink(destination: UpdateItemView(itemViewModel: item)) {
                            VStack(alignment: .leading, spacing: 15){
                                Text(item.name)
                                    .font(.headline)
                                HStack{
                                    Text(item.quantity)
                                        .font(.body)
                                    Text(item.categoryName)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        
                        
                    }
                    .onDelete{ idxSet in
                        idxSet.forEach { idx in
                            let item = itemListViewModel.item[idx]
                            itemListViewModel.delete(itemId: item.id)
                        }
                        
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("Pantry")
                .navigationBarItems( trailing: filterButton)
                .onAppear{
                    itemListViewModel.getAll()
                    
                }
                .animation(.easeInOut, value: 0 )
                .sheet(isPresented: $isPresented, onDismiss: {
                    itemListViewModel.getAll()
                }) {
                    AddItemView()
                }
                
                Button(action: {
                    isPresented = true
                }){
                    
                    Image(
                        systemName: "plus")
                    .frame(width: 20,height: 20)
                    .foregroundColor(.white)
                    .padding()
                    
                    
                }
                .font(.largeTitle)
                .background(Color.blue)
                .clipShape(Circle())
                .padding()
                .contentShape(Circle())
                .shadow(color: .primary,radius: 1,x: 0  , y: 0)
            }
            
        }
        

    }
    
    
    private var filterButton: some View{
        Image(
        systemName: "slider.horizontal.3")
        .contextMenu {
            Button{
                itemListViewModel.filterBy = ""
                itemListViewModel.getAll()
            }
        label:{
                Label("All" , systemImage: "sum")
            }
            Button{
                itemListViewModel.filterBy = "Freezer"
                itemListViewModel.getAll()
            }
        label:{
                Label("Freezer" , systemImage: "thermometer.snowflake")
            }
            Button{
                itemListViewModel.filterBy = "Fridge"
                itemListViewModel.getAll()
            }
        label:{
                Label("Fridge" , systemImage: "scale.3d")
            }
            Button{
                itemListViewModel.filterBy = "Dry pantry"
                itemListViewModel.getAll()
            }
        label:{
                Label("Dry Pantry" , systemImage: "bag.fill")
            }


        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
