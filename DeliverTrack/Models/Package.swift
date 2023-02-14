//
//  Package.swift
//  RastroPacote
//
//  Created by Anthony José on 23/01/23.
//

import Foundation
import SwiftUI
import Combine

class Package: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String = ""
    var object: String = ""
    var status: String = ""
    var tracks: [Track] = [Track(data: Date(), traking: "", status: "")]
    
    init(id: UUID, name: String, object: String, status: String, tracks: [Track]) {
        self.id = id
        self.name = name
        self.object = object
        self.status = status
        self.tracks = tracks
    }
}

class Packages: ObservableObject {
    
    let defaults = UserDefaults.standard
    
    init() {
      getElements()
    }
    
    @Published var items = [Package]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                defaults.set(encoded, forKey: "Items")
            }
        }
    }
    
    func getElements() {
        if let savedItems = defaults.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([Package].self, from: savedItems) {
                self.items = decodedItems
            } else { return }
        }
    }
    
    func remove(_ indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
}


struct PackageListView: View {
    @ObservedObject var packages: Packages = .init()

    var body: some View {
        List {
            ForEach($packages.items) { $pack in
                NavigationLink($pack.name.wrappedValue,
                               destination: PackageDetailView(package: pack, code: pack.object)
                )
            }
        }
    }
}
