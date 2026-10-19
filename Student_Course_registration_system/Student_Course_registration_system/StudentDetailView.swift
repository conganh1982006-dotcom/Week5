import SwiftUI

struct StudentDetailView: View {

    @EnvironmentObject private var school: SchoolManager

    let student: Student

    // Get records for the selected student
    private var studentRecords: [StudentRecord] {
        school.records(for: student)
    }

    var body: some View {
        List {

            // Student information
            Section("Student Information") {

                LabeledContent("Student ID", value: student.id)

                LabeledContent("Name", value: student.getName())

                LabeledContent(
                    "Age",
                    value: "\(student.getAge())"
                )
            }

            // Academic results
            Section("Academic Results") {

                LabeledContent("Weighted Average") {
                    Text(
                        studentRecords.isEmpty
                        ? "N/A"
                        : String(
                            format: "%.2f / 10",
                            school.calculateAverage(for: student)
                        )
                    )
                    .fontWeight(.semibold)
                }

                LabeledContent("Academic Ranking") {
                    Text(school.academicRanking(for: student))
                        .fontWeight(.semibold)
                }
            }

            // Registered subjects
            Section("Registered Subjects") {

                if studentRecords.isEmpty {
                    Text("No registered subjects")
                        .foregroundStyle(.secondary)

                } else {

                    ForEach(
                        Array(studentRecords.enumerated()),
                        id: \.offset
                    ) { item in

                        let record = item.element

                        NavigationLink {
                            EditMarkView(record: record)
                        } label: {

                            VStack(alignment: .leading, spacing: 8) {

                                Text(record.subject.getName())
                                    .font(.headline)

                                HStack {
                                    Text(
                                        "\(record.subject.getCredits()) credits • \(record.academicYear)"
                                    )
                                    .font(.caption)
                                    .foregroundStyle(.secondary)

                                    Spacer()

                                    Text(
                                        String(
                                            format: "%.1f / 10",
                                            record.getMark()
                                        )
                                    )
                                    .font(.subheadline.bold())
                                }

                                Text(
                                    record.isPassed()
                                    ? "Passed"
                                    : "Failed"
                                )
                                .font(.caption.bold())
                                .foregroundStyle(
                                    record.isPassed()
                                    ? Color.green
                                    : Color.red
                                )
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }
            }
        }
        .navigationTitle(student.getName())
        .navigationBarTitleDisplayMode(.inline)
    }
}

