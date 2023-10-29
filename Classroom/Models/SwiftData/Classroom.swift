//
//  Classroom.swift
//  Classroom
//
//  Created by Łukasz Stachnik on 15/10/2023.
//

import Foundation
import SwiftData

@Model
final class Classroom {
    var title = ""
    @Relationship(inverse: \Student.classrooms)
    var students: [Student]? = []

    @Relationship(deleteRule: .cascade, inverse: \Attendance.classroom)
    var attendance: [Attendance]? = []

    var creationDate = Date()

    init(title: String = "", students: [Student] = []) {
        self.students = students
        self.title = title
    }
}

extension Classroom {
    #if DEBUG
        static var `default`: Classroom = .init(title: "Specjalistyczne Oprogramowanie Narzędziowe",
                                                students: [
                                                    Student(name: "Jan", surname: "Kowalski"),
                                                    Student(name: "Joanna", surname: "Kowalska"),
                                                    Student(name: "Adam", surname: "Nowak"),
                                                    Student(name: "Ewa", surname: "Wiśniewska"),
                                                    Student(name: "Piotr", surname: "Dąbrowski"),
                                                    Student(name: "Karolina", surname: "Lewandowska"),
                                                    Student(name: "Kamil", surname: "Wójcik"),
                                                    Student(name: "Anna", surname: "Kamińska"),
                                                    Student(name: "Marek", surname: "Kozłowski"),
                                                    Student(name: "Magdalena", surname: "Jankowska"),
                                                    Student(name: "Tomasz", surname: "Mazurek"),
                                                    Student(name: "Natalia", surname: "Wolska"),
                                                    Student(name: "Michał", surname: "Sawicki"),
                                                    Student(name: "Aleksandra", surname: "Kaczmarek"),
                                                    Student(name: "Krzysztof", surname: "Zawisza"),
                                                ])

    #endif
}
