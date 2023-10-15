//
//  CreateClassroomView.swift
//  Classroom
//
//  Created by Łukasz Stachnik on 15/10/2023.
//

import SwiftUI
import SwiftData

struct CreateClassroomView: View {
	
	@Environment(\.dismiss) var dismiss
	@Environment(\.modelContext) var context
	
	@State private var classroom = Classroom()
	@State private var student: Student = Student(name: "", surname: "")
	@State private var selectedStudents: [Student] = []
	@Query private var students: [Student]
	
    var body: some View {
		List {
			Section {
				HStack {
					TextField("Classroom Title", text: $classroom.title)
					Button {
						withAnimation {
							context.insert(classroom)
							classroom.students = selectedStudents
							dismiss()
						}
					} label: {
						Label("Save", systemImage: "plus")
					}
					.disabled(classroom.title.isEmpty || selectedStudents.isEmpty)
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

			}
			
			Section {
				ForEach(students) { student in
					HStack {
						StudentView(student: student)
						
						Spacer()
						
						if selectedStudents.contains(student) {
							Image(systemName: "circle.fill")
								.onTapGesture {
									withAnimation {
										selectedStudents.removeAll(where: { $0.id == student.id })
									}
								}
						} else {
							Image(systemName: "circle")
								.onTapGesture {
									withAnimation {
										selectedStudents.append(student)
									}
								}
						}
					}
				}
			}
			
		

		}
		.navigationTitle("Create Classroom")
    }
}

#Preview {
    CreateClassroomView()
		.modelContainer(ClassroomContainer.createPreviewContainer())
}
