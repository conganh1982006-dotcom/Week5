
import Foundation
import Combine
final class SchoolManager: ObservableObject {
    let students: [Student]
    let subjects: [Subject]
    @Published private(set) var records: [StudentRecord]

    // Initialize the school manager
    init(
        students: [Student],
        subjects: [Subject],
        records: [StudentRecord]
    ) {
        self.students = students
        self.subjects = subjects
        self.records = records
    }

    // Find all records belonging to a student
    func records(for student: Student) -> [StudentRecord] {
        return records.filter { record in
            record.student.id == student.id
        }
    }

    // Calculate credit-weighted average
    func calculateAverage(for student: Student) -> Double {

        let studentRecords = records(for: student)
        var totalWeightedMarks = 0.0
        var totalCredits = 0
        for record in studentRecords {
            let mark = record.getMark()
            let credits = record.subject.getCredits()
            totalWeightedMarks += mark * Double(credits)
            totalCredits += credits
        }
        // Avoid dividing by zero
        if totalCredits == 0 {
            return 0
        }

        return totalWeightedMarks / Double(totalCredits)
    }
    // Determine academic ranking
    func academicRanking(for student: Student) -> String {
        if records(for: student).isEmpty {
            return "No results"
        }

        let average = calculateAverage(for: student)
        if average >= 8.5 {
            return "Excellent"
        } else if average >= 7.0 {
            return "Good"
        } else if average >= 5.0 {
            return "Average"
        } else {
            return "Fail"
        }
    }

    // Register a student for a subject
    @discardableResult
    func register(
        student: Student,
        subject: Subject,
        academicYear: String,
        mark: Double
    ) -> Bool {

        // Check that student and subject exist
        guard students.contains(where: { $0.id == student.id }),
              subjects.contains(where: { $0.id == subject.id }) else {
            return false
        }

        // Prevent duplicate registration in the same year
        let isDuplicate = records.contains { record in
            record.student.id == student.id &&
            record.subject.id == subject.id &&
            record.academicYear == academicYear
        }
        if isDuplicate {
            return false
        }

        // Reject invalid marks
        guard let newRecord = StudentRecord(
            student: student,
            subject: subject,
            academicYear: academicYear,
            mark: mark
        ) else {
            return false
        }

        records.append(newRecord)
        return true
    }

    // Update an existing mark
    @discardableResult
    func updateMark(
        studentID: String,
        subjectID: String,
        academicYear: String,
        newMark: Double
    ) -> Bool {
        // Validate the new mark
        guard (0.0...10.0).contains(newMark) else {
            return false
        }
        // Find the matching registration
        guard let record = records.first(where: {
            $0.student.id == studentID &&
            $0.subject.id == subjectID &&
            $0.academicYear == academicYear
        }) else {
            return false
        }
        // Notify SwiftUI before changing the class object
        objectWillChange.send()

        return record.updateMark(newMark)
    }
}



