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
	var isPresent: Bool = true
	
	init(student: Student, classroom: Classroom, date: Date, isPresent: Bool) {
		self.student = student
		self.classroom = classroom
		self.date = date
		self.isPresent = isPresent
	}
}
