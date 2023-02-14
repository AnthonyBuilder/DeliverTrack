//
//  ContentView.swift
//  RastroPacote
//
//  Created by Anthony José on 18/01/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var addObjectSheet = false
    
    @EnvironmentObject var packages: Packages
    
    var body: some View {
        NavigationStack {
            ZStack {
                if packages.items.isEmpty == true {
                    NoItemsView(isSheet: $addObjectSheet)
                } else {
                    List {
                        ForEach($packages.items, id: \.id) { $pack in
                            NavigationLink(destination: PackageDetailView(package: pack, code: pack.object)) {
                                PackageDetailList(package: $pack)
                            }
                        }.onDelete { index in
                            packages.remove(index)
                        }
                    }.refreshable {
                        packages.getElements()
                    }
                }
            }
            
            .navigationTitle("Encomendas")
            .toolbar {
                Button(action: { addObjectSheet.toggle() }, label: {
                    Image(systemName: "plus")
                })
            }
        }
        .sheet(isPresented: $addObjectSheet) {
            AddItemsView()
                .environmentObject(packages)
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
    }
}



//model view list
struct PackageDetailList: View {
    
    @Binding var package: Package
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(package.name)
                    .font(.headline)
            }
        }.padding(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
