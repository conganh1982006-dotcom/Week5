
import SwiftUI

struct EditMarkView: View {
    @EnvironmentObject private var school: SchoolManager
    @Environment(\.dismiss) private var dismiss
    let record: StudentRecord
    @State private var markText: String
    @State private var showError = false
    @State private var errorMessage = ""
    // Start with the current mark
    init(record: StudentRecord) {
        self.record = record
        _markText = State(initialValue: String(record.getMark()))
    }
    var body: some View {
        Form {
            // Selected registration
            Section("Registration") {
                LabeledContent(
                    "Student",
                    value: record.student.getName()
                )
                LabeledContent(
                    "Subject",
                    value: record.subject.getName()
                )
                LabeledContent(
                    "Academic Year",
                    value: record.academicYear
                )
            }
            // Edit mark
            Section("Edit Mark") {
                TextField("Enter mark (0-10)", text: $markText)
                    .keyboardType(.decimalPad)
                Text("Mark must be between 0 and 10.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            // Save button
            Section {
                Button("Save Mark") {
                    saveMark()
                }
                .frame(maxWidth: .infinity)
                .fontWeight(.semibold)
            }
        }
        .navigationTitle("Edit Mark")
        .navigationBarTitleDisplayMode(.inline)
        .alert(
            "Unable to Update Mark",
            isPresented: $showError
        ) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
    }
    // Validate and save a new mark
    private func saveMark() {

        // Accept both 8.5 and 8,5
        let normalizedText = markText
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: ",", with: ".")

        // Convert String to Double
        guard let newMark = Double(normalizedText),
              (0.0...10.0).contains(newMark) else {

            errorMessage = "Please enter a number from 0 to 10."
            showError = true
            return
        }
        // Update the existing record
        let success = school.updateMark(
            studentID: record.student.id,
            subjectID: record.subject.id,
            academicYear: record.academicYear,
            newMark: newMark
        )
        if success {
            dismiss()
        } else {
            errorMessage = "The record could not be updated."
            showError = true
        }
    }
}

