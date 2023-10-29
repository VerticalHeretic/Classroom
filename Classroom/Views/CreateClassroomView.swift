//
//  CreateClassroomView.swift
//  Classroom
//
//  Created by Łukasz Stachnik on 15/10/2023.
//

import SwiftData
import SwiftUI

struct CreateClassroomView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context

    @State private var classroom = Classroom()
    @State private var creationStudent: Student = .init(name: "", surname: "")
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
                TextField("Name", text: $creationStudent.name)
                TextField("Surname", text: $creationStudent.surname)

                Button {
                    withAnimation {
                        context.insert(creationStudent)
                        creationStudent = Student(name: "", surname: "")
                    }
                } label: {
                    Text("Add Student")
                }
                .disabled(creationStudent.name.isEmpty || creationStudent.surname.isEmpty)
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
        .toolbar {
            ToolbarItem {
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
    }
}

#Preview {
    CreateClassroomView()
        .modelContainer(ClassroomContainer.createPreviewContainer())
}
