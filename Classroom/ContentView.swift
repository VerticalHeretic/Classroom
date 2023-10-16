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
	@State private var editedClassroom: Classroom?
	@State private var showCreateClassroom = false
	
	var body: some View {
		#if os(macOS)
			NavigationSplitView {
				List(classrooms, selection: $selectedClassroom) { classroom in
					VStack(alignment: .leading) {
						Text(classroom.title)
							.font(.headline)
						Text("Number of students: \(classroom.students?.count ?? 0)")
							.font(.subheadline)
					}
					.tag(classroom)
					.contextMenu {
						Button(action: {
							editedClassroom = classroom
						}, label: {
							Text("Edit")
						})
						
						Button(action: {
							if selectedClassroom == classroom {
								selectedClassroom = nil
							}
							
							context.delete(classroom)
							
						}, label: {
							Label("Delete", systemImage: "trash")
						})
					}
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
				NavigationStack {
					CreateClassroomView()
						.frame(minWidth: 400, minHeight: 400)
				}
			}
			.sheet(item: $editedClassroom) { classroom in
				NavigationStack {
					EditClassroomView(classroom: classroom)
						.frame(minWidth: 400, minHeight: 400)
				}
			}
		#else
			NavigationView {
				List(classrooms) { classroom in
					NavigationLink {
						ClassroomView(classroom: classroom)
					} label: {
						VStack(alignment: .leading) {
							Text(classroom.title)
								.font(.headline)
							Text("Number of students: \(classroom.students?.count ?? 0)")
								.font(.subheadline)
						}
					}
					.swipeActions {
						Button(role: .destructive) {
							context.delete(classroom)
						} label: {
							Label("Remove", systemImage: "trash")
						}
						
						Button {
							editedClassroom = classroom
						} label: {
							Label("Edit", systemImage: "pencil")
						}
					}
				}
				.navigationTitle("Classrooms")
				.toolbar {
					ToolbarItem {
						Button {
							showCreateClassroom = true
						} label: {
							Label("Add Classroom", systemImage: "plus")
						}
					}
				}
			}
			.sheet(item: $editedClassroom) { classroom in
				NavigationStack {
					EditClassroomView(classroom: classroom)
				}
			}
			.sheet(isPresented: $showCreateClassroom) {
				NavigationStack {
					CreateClassroomView()
						.presentationDetents([.medium, .large])
				}
			}
#endif
		}
}

#Preview {
    ContentView()
		.modelContainer(ClassroomContainer.createPreviewContainer())
}
