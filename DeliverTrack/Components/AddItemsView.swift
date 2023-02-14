//
//  AddItemsView.swift
//  RastroPacote
//
//  Created by Anthony José on 01/02/23.
//

import Foundation
import SwiftUI

struct AddItemsView: View {
    
    @EnvironmentObject var packages: Packages
    @Environment(\.presentationMode) var presentationMode

    @State private var numero: String = ""
    @State private var descrição: String = ""

    var body: some View {
        VStack(alignment: .center) {
            
            VStack {
                Text("Adicone um objeto!")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("Informe um código de rastreio fornecido pela transportadora.")
                    .font(.callout)
                    .foregroundColor(.gray)
            }.padding().multilineTextAlignment(.center)
            
            TextField("Número de rastreio", text: $numero)
                .padding(.horizontal)
                .frame(height: 55)
                .background(Color(.systemGray4))
                .cornerRadius(10)

            TextField("Descrição", text: $descrição)
                .padding(.horizontal)
                .frame(height: 55)
                .background(Color(.systemGray4))
                .cornerRadius(10)
            
            Spacer()
            
            
            Button(action: {
                let package = Package(id: UUID(), name: descrição, object: numero, status: "", tracks: [Track(data: Date(), traking: "", status: "")])
                packages.items.append(package)
                packages.getElements()
                presentationMode.wrappedValue.dismiss()
            }, label: {
                    Text("Salvar")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(10)
            })
        }
        .padding()
        .contentShape(Rectangle())
        
    }
}

