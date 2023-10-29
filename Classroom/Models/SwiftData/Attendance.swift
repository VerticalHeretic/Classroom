//
//  Attendance.swift
//  Classroom
//
//  Created by Łukasz Stachnik on 15/10/2023.
//

import Foundation
import SwiftData

@Model
final class Attendance {
    var student: Student?
    var classroom: Classroom?
    var date = Date()

    init(student: Student, classroom: Classroom, date: Date) {
        self.student = student
        self.classroom = classroom
        self.date = date
    }
}
