//
//  DataController.swift
//  NoteAPPCoreData
//
//  Created by Sedat Yıldız on 8.02.2025.
//

import CoreData
import Foundation


class DataController: ObservableObject {
    
    let container = NSPersistentContainer(name: "NoteModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data failed to load: \(error.localizedDescription)")
                
            }
        }
    }
}
