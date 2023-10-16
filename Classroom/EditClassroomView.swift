//
//  EditClassroomView.swift
//  Classroom
//
//  Created by Łukasz Stachnik on 16/10/2023.
//

import SwiftUI
import SwiftData

struct EditClassroomView: View {
	@Environment(\.dismiss) var dismiss
	@Environment(\.modelContext) var context
	
	@Bindable var classroom: Classroom
	@State private var student: Student = Student(name: "", surname: "")
	@State private var selectedStudents: [Student] = []
	@Query private var students: [Student]
	
	var body: some View {
		List {
			Section {
				HStack {
					TextField("Classroom Title", text: $classroom.title)
				}
			}
			
			Section("Add Student") {
				TextField("Name", text: $student.name)
				TextField("Surname", text: $student.surname)
				
				Button {
					withAnimation {
						context.insert(student)
						student = Student(name: "", surname: "")
					}
				} label: {
					Text("Add Student")
				}
				.disabled(student.name.isEmpty || student.surname.isEmpty)
				
				ForEach(students.filter { student in !classroom.students.contains(student) }) { student in
					StudentView(student: student)
						.onTapGesture {
							classroom.students.append(student)
						}
				}
			}
			
			Section("Classroom students") {
				ForEach(classroom.students) { student in
					StudentView(student: student)
					#if os(macOS)
						.contextMenu {
							Button {
								classroom.students.removeAll { $0.id == student.id }
							} label: {
								Text("Remove")
							}
						}
					#else
						.swipeActions {
							Button {
								classroom.students.removeAll { $0.id == student.id }
							} label: {
								Label("Remove", systemImage: "trash")
							}
						}
					#endif
				}
			}
		}
		.navigationTitle("Update Classroom")
		.toolbar {
			ToolbarItem {
				Button(role: .cancel) {
					dismiss()
				} label: {
					Label("Close", systemImage: "xmark")
				}
			}
		}
	}
}

#Preview {
	EditClassroomView(classroom: Classroom.default)
		.modelContainer(ClassroomContainer.createPreviewContainer())
}
