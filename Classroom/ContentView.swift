//
//  ContentView.swift
//  Classroom
//
//  Created by Łukasz Stachnik on 15/10/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
	
	@Environment(\.modelContext) var context
	@Query var classrooms: [Classroom]
	@State private var selectedClassroom: Classroom?
	@State private var showCreateClassroom = false
	
	var body: some View {
		NavigationSplitView {
			List(classrooms, selection: $selectedClassroom) { classroom in
				VStack(alignment: .leading) {
					Text(classroom.title)
						.font(.headline)
					Text("Number of students: \(classroom.students.count)")
						.font(.subheadline)
				}
				.tag(classroom)
			}
		} detail: {
			if let selectedClassroom {
				ClassroomView(classroom: selectedClassroom)
			} else {
				EmptyView()
			}
		}
		.toolbar {
			ToolbarItem {
				Button {
					showCreateClassroom = true
				} label: {
					Label("Add Classroom", systemImage: "plus")
				}
			}
		}
		.sheet(isPresented: $showCreateClassroom) {
			CreateClassroomView()
		}
    }
}

#Preview {
    ContentView()
		.modelContainer(ClassroomContainer.createPreviewContainer())
}
