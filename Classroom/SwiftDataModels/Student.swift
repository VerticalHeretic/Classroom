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
	
	init(name: String, surname: String) {
		self.name = name
		self.surname = surname
	}
}
