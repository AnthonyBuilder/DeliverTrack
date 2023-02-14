//
//  Track.swift
//  RastroPacote
//
//  Created by Anthony José on 23/01/23.
//

import Foundation

class Track: Identifiable, Codable {
    var data: Date = Date()
    var traking: String = ""
    var status: String = ""
        
        init(data: Date, traking: String, status: String) {
            self.data = data
            self.traking = traking
            self.status = status
        }
}
