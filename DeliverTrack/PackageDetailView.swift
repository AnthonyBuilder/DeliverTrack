//
//  PackageDetailView.swift
//  DeliverTrack
//
//  Created by Anthony José on 20/01/23.
//

import SwiftUI

struct PackageDetailView: View {
    
    var package: Package
    var code: String = ""
    
    @State var packApi = [PackageElement]()
    @State var packError: Bool = false
    
    var body: some View {
        if packApi.isEmpty == true && packError == false {
            ProgressView()
                .onAppear() {
                    Task {
                        await Correios().getObject(code) { (result) in
                            switch result {
                            case .success(let pack):
                                packApi = pack
                            case .failure(_):
                                packError = true
                            }
                        }
                    }
                }
        } else {
            if packError == true {
                VStack(alignment: .center) {
                    Text("Objeto não encontrado.")
                        .font(.title)
                    Text("Por favor, verifique o código inserido.")
                        .font(.title3)
                        .foregroundColor(.gray)

                }.padding()
            } else {
                VStack(alignment: .leading) {
                    
                    VStack(alignment: .leading) {
                        Text(packApi.first?.eventos[0].descricao ?? "").font(.title).fontWeight(.semibold)
                        Text(packApi.first?.eventos[0].unidade.endereco.cidade ?? "").font(.callout).foregroundColor(.secondary)
                        Text(packApi.first?.eventos.first?.dtHrCriado ?? "").font(.caption2).foregroundColor(.gray)
                            .padding(.vertical, 1)
                            
                    }.padding()
                    
                    List(packApi.first?.eventos ?? [], id: \.codigo) { eventos in
                       
                        VStack(alignment: .leading) {
                            Text("\(eventos.dtHrCriado)").font(.caption2)
                                .foregroundColor(.gray)
                                .padding(.vertical, 5)
                            Text("\(eventos.descricao)")
                                .font(.title3)
                            Text("\(eventos.unidade.endereco.cidade)")
                                .font(.callout)
                                .foregroundColor(.gray)
                        }.listRowSeparator(.hidden)
                    }
                    .refreshable {
                        Task {
                            await Correios().getObject(code) { (result) in
                                switch result {
                                case .success(let pack):
                                    packApi = pack
                                case .failure(_):
                                    packError.toggle()
                                }
                            }
                        }
                    }
                }.navigationTitle(package.name)
            }
        }
    }
}

