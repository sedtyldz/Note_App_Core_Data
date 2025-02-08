//
//  NoteAPPCoreDataApp.swift
//  NoteAPPCoreData
//
//  Created by Sedat Yıldız on 8.02.2025.
//

import SwiftUI

@main
struct NoteAPPCoreDataApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            NotesView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
