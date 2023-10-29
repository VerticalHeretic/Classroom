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
    
    @Query var attendance: [Attendance]
    
    private var attendanceForToday: [Attendance] {
        attendance.filter { Calendar.autoupdatingCurrent.isDateInToday($0.date) && $0.classroom == self.classroom }
    }
        
    var body: some View {
		List {
            if let students = classroom.students {
                ForEach(students.sorted(by: { $0.name < $1.name })) { student in
                    HStack {
                        StudentView(student: student, isPresent: attendanceForToday.contains { $0.student == student })
                       
                        Spacer()
                        
                        if attendanceMode {
                            if attendanceForToday.contains(where: { $0.student == student }) {
                                Image(systemName: "person.crop.rectangle.badge.plus")
                                    .symbolVariant(.fill)
                                    .onTapGesture {
                                        if let attendance = attendanceForToday.first(where: { $0.student == student }) {
                                            withAnimation {
                                                context.delete(attendance)
                                            }
                                        }
                                    }
                            } else {
                                Image(systemName: "person.crop.rectangle.badge.plus")
                                    .onTapGesture {
                                        let attendance = Attendance(student: student, classroom: classroom, date: .now)
                                        withAnimation {
                                            context.insert(attendance)
                                        }
                                    }
                            }
                        }
                    }
				}
			}
		}
        .navigationTitle(classroom.title)
        #if os(iOS)
        .toolbar {
                ToolbarItem {
                    Button {
                        withAnimation {
                            attendanceMode.toggle()
                        }
                    } label: {
                        Label("Attendance Mode", systemImage: "person.fill.checkmark")
                    }
                }
        }
        #endif
    }
}

#Preview {
    ClassroomView(classroom: .default, attendanceMode: .constant(false))
		.modelContainer(ClassroomContainer.createPreviewContainer())
}
