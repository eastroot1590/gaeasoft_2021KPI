class ParentFoo {
    let name: String
    let number: Int
    
    init(name: String, number: Int) {
        self.name = name
        self.number = number
    }
    
    func common() {
        print("this is common function")
    }
}

class SubFoo: ParentFoo {

    let height: Float

    init(name: String, number: Int, height: Float) {
        self.height = height
        super.init(name: name, number: number)
    }
    
    override func common() {
        super.common()
        print("this is sub common function")
    }
    
    func sub() {
        print("this is sub function")
    }
}

class OtherFoo: ParentFoo {
    func other() {
        print("this is other function")
    }
}

let other = OtherFoo(name: "other foo", number: 3)
other.common()

extension Bool {
    init(rawValue: String) {
        if rawValue == "Y" {
            self = true
        } else {
            self = false
        }
    }
}

let charBool: Bool = Bool(rawValue: "Y")
if charBool {
    print("true")
} else {
    print("false")
}
