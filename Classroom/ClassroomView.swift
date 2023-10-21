//
//  ClassroomView.swift
//  Classroom
//
//  Created by Łukasz Stachnik on 15/10/2023.
//

import SwiftUI

struct ClassroomView: View {
    @Environment(\.modelContext) var context
    
    var classroom: Classroom
    
    @Binding var attendanceMode: Bool
    @Binding var studentsAttending: [Student]

    var body: some View {
		List {
			if let students = classroom.students {
				ForEach(students) { student in
                    HStack {
                        StudentView(student: student)
                       
                        Spacer()
                        
                        if attendanceMode {
                            if studentsAttending.contains(student) {
                                Image(systemName: "person.crop.rectangle.badge.plus")
                                    .symbolVariant(.fill)
                                    .onTapGesture {
                                        studentsAttending.removeAll(where: { $0.id == student.id })
                                    }
                            } else {
                                Image(systemName: "person.crop.rectangle.badge.plus")
                                    .onTapGesture {
                                        studentsAttending.append(student)
                                    }
                            }
                        }
                    }
				}
			}
		}
    }
}

#Preview {
    ClassroomView(classroom: .default, attendanceMode: .constant(false), studentsAttending: .constant([]))
		.modelContainer(ClassroomContainer.createPreviewContainer())
}
