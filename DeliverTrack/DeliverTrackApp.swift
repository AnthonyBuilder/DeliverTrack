//
//  RastroPacoteApp.swift
//  RastroPacote
//
//  Created by Anthony José on 18/01/23.
//

import SwiftUI

@main
struct DeliverTrackApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(Packages())
        }
    }
}
