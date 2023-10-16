//
//  ClassroomView.swift
//  Classroom
//
//  Created by Łukasz Stachnik on 15/10/2023.
//

import SwiftUI

struct ClassroomView: View {
	var classroom: Classroom
	
    var body: some View {
		List {
			ForEach(classroom.students) { student in
				StudentView(student: student)
			}
		}
    }
}

#Preview {
	ClassroomView(classroom: .default)
		.modelContainer(ClassroomContainer.createPreviewContainer())
}
