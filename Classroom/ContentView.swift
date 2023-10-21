//
//  ContentView.swift
//  Classroom
//
//  Created by Łukasz Stachnik on 15/10/2023.
//

import SwiftUI
import SwiftData
import Observation

@Observable final class ContentViewModel {
    
    var selectedClassroom: Classroom?
    var editedClassroom: Classroom?
    var showCreateClassroom = false
    
    // MARK: Attendance Module
    var studentsAttending: [Student] = []
    var attendanceMode = false
}

struct ContentView: View {
	
	@Environment(\.modelContext) var context
	@Query var classrooms: [Classroom]
    @Bindable var model = ContentViewModel()
	
	var body: some View {
		#if os(macOS)
			NavigationSplitView {
                List(classrooms, selection: $model.selectedClassroom) { classroom in
					VStack(alignment: .leading) {
						Text(classroom.title)
							.font(.headline)
						Text("Number of students: \(classroom.students?.count ?? 0)")
							.font(.subheadline)
					}
					.tag(classroom)
					.contextMenu {
						Button(action: {
                            model.editedClassroom = classroom
						}, label: {
							Text("Edit")
						})
						
						Button(action: {
                            if model.selectedClassroom == classroom {
                                model.selectedClassroom = nil
							}
							
							context.delete(classroom)
							
						}, label: {
							Label("Delete", systemImage: "trash")
						})
					}
				}
			} detail: {
                if let selectedClassroom = model.selectedClassroom {
                    ClassroomView(classroom: selectedClassroom, attendanceMode: $model.attendanceMode, studentsAttending: $model.studentsAttending)
				} else {
					EmptyView()
				}
			}
			.toolbar {
				ToolbarItem {
					Button {
                        model.showCreateClassroom = true
					} label: {
						Label("Add Classroom", systemImage: "plus")
					}
				}
                
                if let selectedClassroom = model.selectedClassroom, let students = selectedClassroom.students {
                    ToolbarItem {
                        Button {
                            if model.attendanceMode {
                                if !model.studentsAttending.isEmpty {
                                    model.studentsAttending.forEach {
                                        let attendance = Attendance(student: $0, classroom: selectedClassroom, date: Date(), isPresent: true)
                                        context.insert(attendance)
                                    }
                                    
                                    students.filter { !model.studentsAttending.contains($0) }.forEach {
                                        let attendance = Attendance(student: $0, classroom: selectedClassroom, date: Date(), isPresent: false)
                                        context.insert(attendance)
                                    }
                                   
                                    model.studentsAttending.removeAll()
                                }
                                
                                model.attendanceMode = false
                            } else {
                                model.attendanceMode = true
                            }
                        } label: {
                            Label("Attendance Mode", systemImage: "person.fill.checkmark")
                        }
                    }
                }
			}
            .sheet(isPresented: $model.showCreateClassroom) {
				NavigationStack {
					CreateClassroomView()
						.frame(minWidth: 400, minHeight: 400)
				}
			}
            .sheet(item: $model.editedClassroom) { classroom in
				NavigationStack {
					EditClassroomView(classroom: classroom)
						.frame(minWidth: 400, minHeight: 400)
				}
			}
		#else
			NavigationView {
				List(classrooms) { classroom in
					NavigationLink {
                        ClassroomView(classroom: classroom, attendanceMode: $model.attendanceMode, studentsAttending: $model.studentsAttending)
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
                            model.editedClassroom = classroom
						} label: {
							Label("Edit", systemImage: "pencil")
						}
					}
				}
				.navigationTitle("Classrooms")
				.toolbar {
					ToolbarItem {
						Button {
                            model.showCreateClassroom = true
						} label: {
							Label("Add Classroom", systemImage: "plus")
						}
					}
				}
			}
            .sheet(item: $model.editedClassroom) { classroom in
				NavigationStack {
					EditClassroomView(classroom: classroom)
				}
			}
            .sheet(isPresented: $model.showCreateClassroom) {
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
