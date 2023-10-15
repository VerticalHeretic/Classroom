//
//  StudentView.swift
//  Classroom
//
//  Created by Łukasz Stachnik on 15/10/2023.
//

import SwiftUI

struct StudentView: View {
	var student: Student
	
    var body: some View {
		HStack(spacing: 4) {
			Text(student.name)
			Text(student.surname)
		}
    }
}

#Preview {
	StudentView(student: .init(name: "Jan", surname: "Kowalski"))
}
