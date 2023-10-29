//
//  ContentViewModel.swift
//  Classroom
//
//  Created by Łukasz Stachnik on 29/10/2023.
//

import Foundation

@Observable final class ContentViewModel {
    
    var selectedClassroom: Classroom?
    var editedClassroom: Classroom?
    var showCreateClassroom = false
    
    // MARK: Attendance Module
    var studentsAttending: [Student] = []
    var attendanceMode = false
}
