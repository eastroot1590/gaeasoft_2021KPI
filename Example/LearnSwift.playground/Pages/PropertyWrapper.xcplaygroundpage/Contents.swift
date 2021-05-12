struct Foo {
    private var storedName: String = ""

    var name: String {
        get { return storedName }
        set { storedName = newValue.uppercased() }
    }
}

var foo = Foo()
foo.name = "london"
print(foo.name)

@propertyWrapper
struct FixCase {
    private(set) var value: String = ""

    var wrappedValue: String {
        get { value }
        set { value = newValue.uppercased() }
    }

    init(wrappedValue initialValue: String) {
        self.wrappedValue = initialValue
    }
}

struct Bar {
    @FixCase var name: String
    @FixCase var city: String
    @FixCase var country: String
}

var bar = Bar(name: "gaea", city: "london", country: "korea")
print("\(bar.name) \(bar.city) \(bar.country)")

@propertyWrapper
struct MinMax<T: Comparable> {
    var value: T
    let min: T
    let max: T

    var wrappedValue: T {
        get { value }
        set {
            if newValue > max {
                value = max
            } else if newValue < min {
                value = min
            } else {
                value = newValue
            }
        }
    }

    init(wrappedValue: T, min: T, max: T) {
        value = wrappedValue
        self.min = min
        self.max = max
    }
}

struct Demo {
    @MinMax(min: 100, max: 300) var value: Int = 100
}

var demo = Demo()
demo.value = 400
print(demo.value)
