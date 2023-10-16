//
//  Student.swift
//  Classroom
//
//  Created by Łukasz Stachnik on 15/10/2023.
//

import Foundation
import SwiftData

@Model
final class Student {
	var name: String
	var surname: String
	var classrooms: [Classroom]
	
	init(name: String, surname: String, classrooms: [Classroom] = []) {
		self.name = name
		self.surname = surname
		self.classrooms = classrooms
	}
}
