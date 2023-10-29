//
//  ClassroomView.swift
//  Classroom
//
//  Created by Łukasz Stachnik on 15/10/2023.
//

import SwiftUI
import SwiftData

struct ClassroomView: View {
    @Environment(\.modelContext) var context
    
    let classroom: Classroom
    
    @Binding var attendanceMode: Bool
    @Binding var studentsAttending: [Student]
    
    @Query var attendance: [Attendance]
    
    private var attendanceForToday: [Attendance] {
        attendance.filter { Calendar.autoupdatingCurrent.isDateInToday($0.date) && $0.classroom == self.classroom }
    }
        
    var body: some View {
		List {
			if let students = classroom.students {
				ForEach(students) { student in
                    HStack {
                        StudentView(student: student, isPresent: attendanceForToday.contains { $0.student == student })
                       
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
