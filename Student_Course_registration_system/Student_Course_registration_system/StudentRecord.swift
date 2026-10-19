import Foundation
class StudentRecord{
    let student: Student
    let subject: Subject
    private var mark: Double
    let academicYear: String
    
    init?(student: Student, subject: Subject, academicYear: String, mark: Double) {
        guard mark >= 0 && mark <= 100 else {
            return nil
        }
        self.student = student
        self.subject = subject
        self.academicYear = academicYear
        self.mark = mark
    }
    
    func isPassed() -> Bool {
        return mark >= 5.0
    }
    func getMark() -> Double {
        return mark
    }
    @discardableResult func updateMark(_ newMark: Double) -> Bool {
        if newMark >= 0 && newMark <= 100 {
            mark = newMark
            return true
        }
        return false
    }
}
