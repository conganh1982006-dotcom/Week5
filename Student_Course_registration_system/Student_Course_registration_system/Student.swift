import Foundation
class Student: Identifiable {
    var id: String
    private var name: String
    private var age: Int
    
    init(id: String, name: String, age: Int) {
        self.id = id
        self.name = name
        self.age = age
    }
    func getName() -> String {
        return name
    }
    func getAge() -> Int {
        return age
    }
    func setName(_ newName: String) {
        name = newName
    }
    func setAge(_ newAge: Int) {
        if age > 0{
            age = newAge
        }
    }
    func displayInfo() -> String {
        return "ID: \(id), Name: \(name), Age: \(age)"
    }
}
