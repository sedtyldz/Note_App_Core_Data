//
//  ContentView.swift
//  NoteAPPCoreData
//
//  Created by Sedat Yıldız on 8.02.2025.
//

import SwiftUI

struct NotesView: View {
    @Environment(\.managedObjectContext) var moc
    @State var note: String = ""
    @FetchRequest(sortDescriptors: []) var notes: FetchedResults<NoteEntity>
    @State var errorMessage: String = ""
    @State var showError: Bool = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.blue.opacity(0.5), Color.green.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Track Your Notes")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 40)
                
                TextField("Write Something ...", text: $note)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color.white.opacity(0.9)))
                    .shadow(radius: 5)
                    .padding(.horizontal, 20)
                    .font(.title3)
                
                Button(action: {
                    add(note: &note)
                }) {
                    Text("Add Note")
                        .font(.title2)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color.blue))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                }
                .padding(.horizontal, 20)
                
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(notes) { note in
                            HStack {
                                Text(note.note ?? "Unknown")
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.9)))
                                    .shadow(radius: 3)
                                
                                Button(action: {
                                    delete(note: note)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                        .padding()
                                        .background(Circle().fill(Color.white.opacity(0.9)))
                                        .shadow(radius: 3)
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                }
                .frame(height: 400)
            }
            .padding(.bottom, 20)
        }
        .alert("Error", isPresented: $showError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(errorMessage)
        }
    }
    
    func add(note: inout String) {
        if note.isEmpty {
            errorMessage = "Note cannot be empty!"
            showError = true
            note = ""
            return
        }
        if note.count >= 20 {
            errorMessage = "Note must be less than 20 characters!"
            showError = true
            note = ""
            return
        }
        let noteObj = NoteEntity(context: moc)
        noteObj.note = note
        noteObj.id = UUID()
        
        do {
            try moc.save()
            note = ""
        } catch {
            errorMessage = "Failed to save note."
            showError = true
            note = ""
        }
    }
    
    func delete(note: NoteEntity) {
        moc.delete(note)
        do {
            try moc.save()
        } catch {
            errorMessage = "Failed to delete note."
            showError = true
        }
    }
}

#Preview {
    NotesView()
}
