//
//  NoItemsView.swift
//  DeliverTrack
//
//  Created by Anthony José on 11/02/23.
//

import SwiftUI

struct NoItemsView: View {
    
    @Binding var isSheet: Bool
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text("Não há itens.")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("Você é uma pessoa que quer estar informado sobre suas compras? acho que você deveria clicar no botão adicionar e adicionar vários itens para não perder suas encomendas de vista!")
                    .foregroundColor(.secondary)
                    .font(.callout)
                
                Button(action: { withAnimation(.spring()) {
                    isSheet.toggle()
                } }) {
                    Text("Adicionar Encomenda 🥳")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }.padding(.top)
                
            }
            .multilineTextAlignment(.center)
            .padding(40)

        }
        
        
    }
}

