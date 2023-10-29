//
//  ClassroomApp.swift
//  Classroom
//
//  Created by Łukasz Stachnik on 15/10/2023.
//

import SwiftData
import SwiftUI

@main
struct ClassroomApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(ClassroomContainer.create())
        .commands {
            Menus()
        }
    }
}

actor ClassroomContainer {
    @MainActor
    static func create() -> ModelContainer {
        let schema = Schema([Classroom.self, Student.self, Attendance.self])
        let configuration = ModelConfiguration()
        let container = try! ModelContainer(for: schema, configurations: configuration)

        return container
    }

    @MainActor
    static func createPreviewContainer() -> ModelContainer {
        let schema = Schema([Classroom.self, Student.self, Attendance.self])
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: schema, configurations: configuration)
        container.mainContext.insert(Classroom.default)

        return container
    }
}
