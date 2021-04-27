var x = 10
var y = x + 10  // y is 20
var z = x % 3   // z is 1
x += 20

var result: Bool
result = x < y  // result is true

for i in 0...10 {
    print(i)
}

print("large number is \(x > y ? x : y)")

var a = 10
let b = 5

// 비트 연산자
print(~a)
print(a | b)
print(a & b)
print(a ^ b)

print(a << 1)
print(a >> 1)
a <<= 3
print(a)
