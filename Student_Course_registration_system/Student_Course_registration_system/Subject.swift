import Foundation


class Subject: Identifiable {
    var id: String
    private var name: String
    private var credits: Int
    
    init(id: String, name: String, credits: Int) {
        self.id = id
        self.name = name
        self.credits = credits
    }
    func getName() -> String {
        return name
    }
    func getCredits() -> Int {
        return credits
    }
    func setName(_ newName: String) {
        name = newName
    }
    func setCredits(_ newCredit: Int){
        if newCredit > 0{
            credits =  newCredit
        }
    }
    func displayInfo() -> String {
        return "Name: \(name), Credits: \(credits)"
    }
    
}
