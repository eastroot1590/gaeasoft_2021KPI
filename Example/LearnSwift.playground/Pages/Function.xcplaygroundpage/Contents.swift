func swap(lhs: inout Int, rhs: inout Int) {
    let temp = lhs
    lhs = rhs
    rhs = temp
}

var a = 10
var b = 20

swap(lhs: &a, rhs: &b)
print("\(a) \(b)")

func request(complete: (String) -> Void) {
    complete("success")
}

// closure 헨들러
request(complete: { (response: String) in
    print(response)
})

// 생략된 표현
request { response in
    print(response)
}
