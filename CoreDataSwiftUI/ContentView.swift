//
//  ContentView.swift
//  CoreDataSwiftUI
//
//  Created by Oron Ben Zvi on 2/9/20.
//  Copyright © 2020 Oron Ben Zvi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @FetchRequest(entity: ProfessionBook.entity(), sortDescriptors: []) var professionBooks: FetchedResults<ProfessionBook>

    func professions(for book: ProfessionBook) -> [Profession] {
        book.professions?.allObjects as? [Profession] ?? []
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(professionBooks, id: \.self) { (book: ProfessionBook) in
                    Section(header: Text(book.name ?? "Unknown")) {
                        ForEach(self.professions(for: book), id: \.self) { (profession: Profession) in
                            Text(profession.name ?? "Unknown")
                        }
                    }
                }
            }
            .navigationBarTitle("Professions")
            .listStyle(GroupedListStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        let paladin = Profession(context: context)
        paladin.id = UUID()
        paladin.name = "Paladin"

        let wizard = Profession(context: context)
        wizard.id = UUID()
        wizard.name = "Wizard"

        let bard = Profession(context: context)
        bard.id = UUID()
        bard.name = "Bard"

        let professionBook = ProfessionBook(context: context)
        professionBook.id = UUID()
        professionBook.name = "PHB"
        professionBook.professions = [paladin, wizard, bard]

        let artificier = Profession(context: context)
        artificier.id = UUID()
        artificier.name = "Artificier"

        let criticalRole = ProfessionBook(context: context)
        criticalRole.id = UUID()
        criticalRole.name = "Critical Role"
        criticalRole.professions = [artificier]

        return ContentView()
            .environment(\.managedObjectContext, context)
    }
}
