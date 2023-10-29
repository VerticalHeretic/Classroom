//
//  EditClassroomView.swift
//  Classroom
//
//  Created by Łukasz Stachnik on 16/10/2023.
//

import SwiftData
import SwiftUI

struct EditClassroomView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context

    @Bindable var classroom: Classroom
    @State private var student: Student = .init(name: "", surname: "")
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

                if let classroomStudents = classroom.students {
                    ForEach(students.filter { student in !classroomStudents.contains(student) }) { student in
                        StudentView(student: student)
                            .onTapGesture {
                                classroom.students?.append(student)
                            }
                    }
                }
            }

            if let students = classroom.students {
                Section("Classroom students") {
                    ForEach(students) { student in
                        StudentView(student: student)
                        #if os(macOS)
                            .contextMenu {
                                Button {
                                    classroom.students?.removeAll { $0.id == student.id }
                                } label: {
                                    Text("Remove")
                                }
                            }
                        #else
                            .swipeActions {
                                    Button {
                                        classroom.students?.removeAll { $0.id == student.id }
                                    } label: {
                                        Label("Remove", systemImage: "trash")
                                    }
                                }
                        #endif
                    }
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
