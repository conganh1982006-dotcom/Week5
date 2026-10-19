
import SwiftUI

struct ContentView: View {

    // Create and own the shared manager
    @StateObject private var school = SchoolManager(
        students: SampleData.students,
        subjects: SampleData.subjects,
        records: SampleData.records
    )

    var body: some View {
        NavigationStack {
            StudentListView()
        }
        .environmentObject(school)
    }
}

#Preview {
    ContentView()
}

