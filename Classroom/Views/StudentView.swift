//
//  StudentView.swift
//  Classroom
//
//  Created by Łukasz Stachnik on 15/10/2023.
//

import SwiftUI

struct StudentView: View {
	var student: Student
    var isPresent: Bool?
	
    var body: some View {
		HStack(spacing: 4) {
			Text(student.name)
			Text(student.surname)
            
            Spacer()
            
            if let isPresent, isPresent {
                Image(systemName: "book")
                    .symbolVariant(.fill)
            }
		}
        .padding()
        .frame(height: 24)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
	StudentView(student: .init(name: "Jan", surname: "Kowalski"), isPresent: true)
        .modelContainer(ClassroomContainer.createPreviewContainer())
}
