
import SwiftUI

struct StudentListView: View {
    // Access the shared school manager
    @EnvironmentObject private var school: SchoolManager
    var body: some View {
        List {
        // Application summary
            Section {
                VStack(alignment: .leading, spacing: 10) {
                    Text("University Academic Portal")
                        .font(.title2.bold())
                    Text("Student course registration system")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    HStack(spacing: 15) {
                        Label("\(school.students.count) students",systemImage: "person.3"
                        )
                        Label(
                            "\(school.records.count) records",systemImage: "book.closed"
                        )
                    }.font(.caption).foregroundStyle(.secondary)
                }.padding(.vertical, 8)
            }
            // Student list
            Section("Students") {
                ForEach(school.students) { student in
                    NavigationLink {
                        StudentDetailView(student: student)
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: "person.crop.circle.fill").font(.system(size: 35)).foregroundStyle(.blue)
                            VStack(alignment: .leading, spacing: 4) {
                                Text(student.getName()).font(.headline)
                                Text("ID: \(student.id) • Age: \(student.getAge())").font(.caption).foregroundStyle(.secondary)
                            }
                            Spacer()
                            Text(
                                String(format: "%.2f",school.calculateAverage(for: student)
                                )
                            ).font(.subheadline.bold())
                        }.padding(.vertical, 5)
                    }
                }
            }
        }.navigationTitle("Students")
    }
}


