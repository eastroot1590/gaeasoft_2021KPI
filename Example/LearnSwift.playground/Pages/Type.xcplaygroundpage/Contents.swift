var flag: Int = 5

if flag != 0 {
    print("flag is not zero")
}

// MARK: 정수
print("Int64 max=\(Int64.max) min=\(Int64.min)")

var sixfour: Int64 = 10
var threetwo: Int32 = 5
//sixfour = threetwo

// MARK: 문자열
let apple: Int = 10
let banana: Int = 5

var character: Character = "s"
//var string: String = character

print("there are \(apple) apples and \(banana) bananas.")

if flag != 0 {
    let multiLine: String = """
        hello
        I
        am
        geaasoft
    """
    
    print(multiLine)
}

// MARK: 튜플
let sampleTupleNoName: (Int, Int, String) = (1, 2, "sample")
print(sampleTupleNoName.2)
let sampleTupleNamed: (first: Int, second: Int, name: String) = (1, 2, "sample")
print(sampleTupleNamed.name)

// MARK: 옵셔널
var foo: Int?
// foo is nil
foo = 10
// no foo is 10

print(foo)
if var f = foo {
    f += 10
    print(f)
    print(foo!)
}
