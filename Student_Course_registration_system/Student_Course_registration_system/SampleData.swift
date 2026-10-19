//
//  SampleData.swift
//  Student_Course_registration_system
//
//  Created by MAY 02 on 19/10/26.
//

import Foundation

enum SampleData {

    // Create four students
    static let students: [Student] = [
        Student(id: "S001", name: "May", age: 20),
        Student(id: "S002", name: "John", age: 19),
        Student(id: "S003", name: "Jane", age: 21),
        Student(id: "S004", name: "Alice", age: 20)
    ]

    // Create four subjects
    static let subjects: [Subject] = [
        Subject(id: "MAT1", name: "Calculus", credits: 4),
        Subject(id: "PHY1", name: "Physics", credits: 3),
        Subject(id: "CS1", name: "Programming", credits: 3),
        Subject(id: "ENG1", name: "English", credits: 2)
    ]

    // Create eight student records
    private static let possibleRecords: [StudentRecord?] = [
        StudentRecord(student: students[0], subject: subjects[0], academicYear: "2026-2027", mark: 8.5),
        StudentRecord(student: students[0], subject: subjects[1], academicYear: "2026-2027", mark: 7.0),

        StudentRecord(student: students[1], subject: subjects[2], academicYear: "2026-2027", mark: 6.0),
        StudentRecord(student: students[1], subject: subjects[3], academicYear: "2026-2027", mark: 8.0),

        StudentRecord(student: students[2], subject: subjects[0], academicYear: "2026-2027", mark: 4.0),
        StudentRecord(student: students[2], subject: subjects[1], academicYear: "2026-2027", mark: 6.0),

        StudentRecord(student: students[3], subject: subjects[2], academicYear: "2026-2027", mark: 9.0),
        StudentRecord(student: students[3], subject: subjects[3], academicYear: "2026-2027", mark: 9.5)
    ]

    // Keep only successfully created records
    static let records: [StudentRecord] = possibleRecords.compactMap { $0 }
}



