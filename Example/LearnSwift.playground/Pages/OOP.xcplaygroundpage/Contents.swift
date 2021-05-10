class lowerCase {
    let content: String = "lowerCase"
}

let lowerCaseInstance = lowerCase()

print(lowerCaseInstance.content)

class Foo {
    let name: String

    init(name: String) {
        self.name = name
    }

    deinit {
        print("Foo deinitialized")
    }

    func instanceMethod() {
        print("instance method")
    }
    
    class func typeMethod() {
        print("type method")
    }
}

let foo = Foo(name: "Foo")

foo.instanceMethod()
Foo.typeMethod()  // error: static member 'typeMethod' cannot be used on instance of type 'Foo'
Foo.typeMethod()

class Bar {
    var count: Int = 0
    
    var countPlusTwo: Int {
        get {
            return count + 2
        }
        set {
            count = newValue - 2
        }
    }
}

let bar = Bar()
bar.count = 10
print(bar.countPlusTwo)
