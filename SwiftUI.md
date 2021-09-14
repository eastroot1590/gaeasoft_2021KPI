# SwiftUI

## 0. 서론

닐 스미스의 저서 *SwiftUI Essentials iOS Edition*을 번역한 책 *SwiftUI 기반의 iOS 프로그래밍*을 공부하면서 정리한 내용을 요약했습니다. SwiftUI는 Swift 문법을 사용하는 App 개발 프레임워크이기 때문에 기본적으로 Swift문법에 대한 내용이 많습니다.

## 1. Swift 기본 자료형

Swift는 **type-safe** 언어이기 때문에 모든 변수는 선언될 때 즉, 컴파일 시점에 컴파일러가 자료형을 추론할 수 있어야 한다. 

기본적으로 정수, 실수, 문자, 문자열 저장할 수 있는 자료형을 가지고 있으며, 같은 정수형 자료형이라도 사용하는 비트 개수에 따라서 `Int32`, `Int16` 등 세부적으로 나뉜 자료형도 지원한다. 

### 1.1. Bool

참, 거짓을 나타내는 `Bool` 자료형의 경우 `true`, `false` 상수를 지원하기 때문에 코드의 가독성을 더욱 높일 수 있다.

앞서 말했듯이 Swift는 **type-safty**를 굉장히 엄격하게 준수해서 대부분 언어에서 지원하는 **묵시적 캐스팅**을 지원하지 않는다. 즉, `0`은 `false`와 다르게 처리하며, 만약 아래와 같은 조건식을 만든다면 컴파일 에러를 발생시킨다.

```swift
var flag: Int = 0

if (flag) {  // Type 'Int' cannot be used as a boolean; test for '!= 0' instead
	print("flag is no zero.")
}
```

### 1.2. 정수

기본적으로 Int를 사용하고 특별한 경우 Int64, Int16 등을 사용하기도 한다. 각 자료형은 구조체로 정의되어 있고, 내부적으로 자신이 표현할 수 있는 최대값, 최소값을 가지고 있다.

```swift
print("Int64 max=\(Int64.max) min=\(Int64.min)")
// Int64 max=9223372036854775807 min=-9223372036854775808
```

엄격한 타입 규칙은 같은 정수형 자료형이라도 캐스팅이 안되도록 제한한다. 심지어 더 큰 비트를 사용하는 자료형으로의 캐스팅도 제한한다.

```swift
var a: Int64 = 10
var b: Int32 = 5
a = b  // Cannot assign value of type 'Int32' to type 'Int64'
```

### 1.3. 실수

32비트를 사용하는 `Float`, 64비트를 사용하는 `Double`을 제공한다. 정수형과 마찬가지로 두 자료형 모두 실수를 표현하지만 서로 캐스팅 되지 않는다.

### 1.4. 문자열

Swift의 문자열은 `String`,문자는 `Character`라는 자료형을 사용하며 `String`에는 문자열을 다룰 수 있는 수많은 기능이 내장되어 있다. 각 문자는 **그래핌 클러스터(Grapheme Cluster)** 형태로 저장되기 때문에 하나의 문자를 두개 이상의 유니코드로 구성한다.

문자열과 문자도 엄연히 다른 자료형으로 보기 때문에 서로 묵시적 캐스팅은 안된다.

```swift
var charactor: Charactor = "hello"  // Cannot convert value of type 'String' to specified type 'Character'
```

문자열에 변수를 대입해서 새로운 문자열을 만드는 **문자열 보간(String Interpolation)**도 문법적으로 지원하기 때문에 문자열을 생성하는 코드를 간소화하고 가독성을 높일 수 있다.

```swift
let apple: Int = 10
let banana: Int = 5

print("there are \(apple) apples and \(banana) bananas.")
// there are 10 apples and 5 bananas.
```

여러줄의 문자열을 저장하고 싶을 때 `"""`기호로 감싸서 표현할 수 있다. 코드 탭이 깊어진 상태로 이 표현식을 쓰면 들여쓰기가 망가지게 되는데 마지막 `"""`기호와 맞추기만 하면 탭을 적절히 맞출 수 있다.

```swift
let index: Int = 6

if index > 0 {
	let multiline = """
		hello
		I
		am
		gaeasoft
		"""
	print(multiline)
}
```

위 코드에서 마지막 `"""`기호가 줄과 같은 탭 레벨에 있기 때문에 모든 줄에 아무것도 붙지 않는다.

```swift
let index: Int = 6

if index > 0 {
	let multiline = """
		hello
		I
		am
		gaeasoft
	"""
	print(multiline)
}
```

예를 들어 이렇게 작성하면 마지막 `"""`기호가 문자보다 한 레벨 높기 때문에 모든 줄 맨 앞에 탭이 들어가서 들여쓰기가 된다.

### 1.5. 튜플

**튜플(tuple)**은 Swift에서 가장 단순하면서 가장 강력한 기능을 가진 자료형이다. 튜플은 여러개의 자료형을 하나의 변수로 사용할 수 있는 자료형으로, 튜플을 구성하는 자료형이 모두 같지 않아도 되기 때문에 사용성이 굉장히 좋다. 이런 튜플의 특성을 활용해서 함수가 여러개의 자료형을 반환하도록 만들 수도 있다. 

튜플을 구성하는 각 데이터들은 `0`부터 시작되는 인덱스 숫자로도 접근할 수도 있고, 튜플을 선언할 때 이름을 지정해서 접근할 수도 있다.

```swift
let sampleTupleNoName: (Int, Int, String) = (1, 2, "sampleNoName")
print(sampleTupleNoName.2)
// sampleNoName
let sampleTupleNamed: (age: Int, name: String) = (15, "john")
print(sampleTupleNamed.name)
// john
```

### 1.6. 옵셔널

Swift가 제공하는 옵셔널(optional)은 다른 대부분의 언어에서 지원하지 않는 개념이다. 옵셔널은 `nil`이 될 수 있는 변수라는 것을 뜻하며 자료형 뒤에 `?` 기호를 붙혀서 사용한다. 예를들어 아래 `foo`는 값을 가지고 있을 수도 있지만 `nil`일 수도 있다. 일반 변수는 선언만 하고 초기화를 하지 않으면 사용할 수 없지만 옵셔널의 경우 `nil`로 자동 초기화가 된다.

```swift
var foo: Int?
// foo is nil
foo = 10
// no foo is 10
```

옵셔널 자료형에 들어있는 값을 **래핑(wrapped)**된 값이라고 표현하며, 래핑된 값을 실제로 꺼내오는 것을 **언래핑(unwrapping**)한다 라고 한다. 위 예제에서 `10`은 래핑된 값이다. 그리고 이 값을 실제로 사용하기 위해서는 아래처럼 `!` 기호로 래핑된 값을 꺼내오는 것을 **강제 언래핑(forced unwrapping)**이라고 한다.

```swift
print(foo)
// Optional(10)
print(foo!)
// 10
```

강제 언래핑은 말 그대로 강제로 값을 꺼내오는 것이기 때문에 옵셔널 변수 안에 `nil`이 들어있으면 위험할 수도 있다. 그래서 안전하게 래핑된 값을 꺼내올 수 있는 **옵셔널 바인딩(optional binding)**기법을 사용할 수 있다.

```swift
if let bindedFoo = foo {
	print(foo)
} else {
	print("foo is nil")
}
```

`bindedFoo` 처럼 옵셔널 바인딩에 사용하는 임시 상수는 해당 if블록 안에서만 유효하기 때문에 이름을 옵셔널 변수와 똑같이 선언해도 충돌이 발생하지 않는다.

Swift는 type-safe 언어로 옵셔널과 옵셔널이 아닌 타입도 서로 다른 타입이라고 추론하기 때문에 옵셔널을 잘 활용하면 `nil`을 참조해서 발생하는 런타임 에러를 최소화 할 수 있다.

### 1.7. 타입 캐스팅

위에서 살펴본 타입들을 서로 변환하는 작업을 **타입 캐스팅**이라고 하는데, Swift는 `is`, `as` 라는 직관적인 키워드로 타입 캐스팅을 제공한다. 

- `is`

    해당 타입이 맞는지 검사하는 **타입 검사**를 해서 `Bool`을 반환한다.

- `as`

    실제 그 타입으로 변환한다. 특히 `as`는 `as?` 키워드를 사용해서 해당 캐스팅이 유효한지 검사한 후 안전한 경우에만 캐스팅을 수행하도록 할 수도 있다.

## 2. Swift 기본 연산자

Swift의 가장 기본적인 표현식은 하나의 **연산자(operator)**, 두개의 **피연산자(operand)**, 하나의 **할당자(assignment)**로 구성된다.

```swift
var foo = 1 + 2
```

위 예제에서 `+`연산자는 두개의 피연산자 `1`, `2`를 더하는 역할을 하고 할당자 `=`는 결과를 foo에 할당하는 역할을 한다.

범위 연산자를 제외한 이항 연산자들은 모두 연산자 양 끝에 공백을 추가해서 연산자와 항을 구분해야 한다.

### 2.1. 산술 연산자

Swift가 제공하는 산술연산자는 기본적으로 이항 연산자(binary operator)로 두개의 항을 필요로 한다. 단, 음수기호인 `-`만 유일하게 단항 연산자고 C++이나 다른 언어에서 흔히 사용하는 증감 연산자 `++`, `--`는 제공하지 않는다. 이항 연산자에는 `+`, `-`, `*`, `/`, `%`가 있다.

```swift
var x = 10
var y = x + 10  // y is 20
var z = x % 3   // z is 1
```

### 2.2. 복합 산술 연산자

산술 연산자와 할당 연산자를 조합해서 표현식의 길이를 줄여주면서도 의미를 모호하게 하지 않기 때문에 Swift에서도 여전히 제공하고 있다.

```swift
// x = 10
x += 5  // x is 15
```

### 2.3. 비교 연산자

비교를 수행하기 위해 다양한 연산자를 제공한다. 비교 연산자 또한 산술 연산자와 마찬가지로 2개의 항을 필요로 하는 이항 연산자다. 비교 결과는 `Bool` 자료형으로 변환되며 `==`, `>`, `>=`, `<`, `<=`, `!=`가 있다.

```swift
var result: Bool
// x = 15
// y = 20
result = x < y  // result is true
```

### 2.4. 논리 연산자

논리식을 만들 수 있는 논리 연산자 `!`, `||`, `&&`도 제공한다. 나머지 두개는 이항 연산자지만 `!`는 단항 연산자로 `Bool`값을 반대로 바꿔준다.

```swift
if (x < y) || (x == y) {
	print("y is greater or equal than x")
}
```

### 2.5. 범위 연산자

Swift는 특이하게 범위를 지정할 수 있는 범위 연산자를 제공한다. 범위에는 **닫힌 범위(closed range)**, **열린 범위(open range)**가 있고, 반복 작업을 할때 굉장히 유용하게 사용할 수 있다.

닫힌 범위는 처음과 마지막을 포함하는 범위를 말하고, 열린 범위는 열려있는쪽의 마지막 를 포함하지 않는 범위를 말한다. 단, 열린 범위를 지정할 때 시작 범위는 열 수 없기 때문에 마지막 값을 포함할지 말지가 달라진다.

```swift
0...10  // 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
0..<10  // 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
```

### 2.6. 삼항 연산자

코드의 길이를 줄여주는 연산자로 삼항 연산자도 제공한다.

```swift
let x = 10
let y = 20

print("large number is \(x > y ? x : y)")
```

### 2.7. 비트 연산자

컴퓨터의 데이터는 모두 비트로 이루어져 있기 때문에 이 비트를 다룰 수 있는 비트 연산자도 제공한다. 비트식으로는 NOT, AND, OR, XOR를 제공하고 각 연산자는 아래와 같이 표현한다.

```swift
let x = 10 // 0x1010
let y = 5  // 0x0101

print(~x)     // NOT: -11
print(x | y)  // OR:   15
print(x & y)  // AND:   0
print(x ^ y)  // XOR:  15
```

비트를 비교하는게 아니라 비트 전체를 이동시키는 시프트 연산자도 제공한다.

```swift
print(x << 2)  // Shift Right: 40
print(x >> 1)  // Shift Left:   5
```

### 2.8. 복합 비트 연산자

비트 연산자와 할당 연산자를 조합해서 연산 결과를 다시 할당하는 복합 비트 연산자도 제공한다 사용법은 복합 산술 연산자를 사용하는 것과 동일하다.

```swift
var x = 10
x <<= 3  // x is 80
```

## 3. Swift 흐름제어

Swift도 프로그램을 어떤 조건에 실행하고, 얼마나 반복할지 제어하는 흐름제어 문법을 제공한다. 흐름제어는 반복을 제어하는 **반복 제어(looping control)**과 조건에 따라 실행을 제어하는 **조건부 제어 흐름(conditional flow control)**이 있다.

### 3.1. 반복 제어

말 그대로 프로그램의 반복을 제어한다.

**3.1.1. for in**

`for in` 문법은 앞서 배운 range를 기반으로 range의 각 인덱스를 상수에 대입하면서 반복을 수행한다. 

```swift
for i in 1...5 {
	// 반복
}
```

범위는 collection 또는 range가 될 수 있고, `String`도 범위로 사용할 수 있어서 `String`을 구성하는 각 문자 개수만큼 반복할 수 있다. `for in` 안에서 range 인덱스 상수를 사용할 필요가 없다면 `_`로 이름을 생략할 수도 있다.

**3.1.2. while**

반복 횟수를 알고 있어야 하는 `for in`과 달리 `while`은 조건식이 참일 동안 반복한다. 반복을 돌면서 조건식을 검사한다.

**3.1.3. repeat while**

Swift 1.x의 `do while`이 변형된 문법으로 `while`과 비슷하지만 조건식의 검사를 마지막에 수행한다는 점이 다르다. 때문에 구문 안에 코드는 최초 1회는 조건식의 참/거짓에 관계없이 실행된다.

```swift
var i = -10
repeat {
	i += 5
} while i > 0
// i is -5
```

**3.1.4. break**

반복문의 횟수를 채우거나 반복 조건에 만족하지 않아도 반복을 종료하고 싶을 때 `break`로 빠져나올 수 있다.

**3.1.5. continue**

반복 도중에 남은 코드를 건너뛰고 다시 처음부터 실행하고 싶을 때 `continue`를 사용해서 건너뛸 수 있다.

### 3.2. 조건부 흐름 제어

조건에 따라 프로그램의 흐름을 제어한다.

**3.2.1. if**

조건식이 참일 경우 코드 블록을 실행한다. 조건문이 거짓일 경우 실행하는 블록인 `else` 또는 거짓일 경우 검사할 새로운 조건식을 제시하는 `else if`를 제공한다.

```swift
let i = 10

if i < 5 {
	print("i is lower than 5")
} else if i > 5 {
	print("i is greater than 5")
} else {
	print("i is 5")
}
```

**3.2.2. guard**

Swift 2.x 부터 도입된 기능으로 조건식이 참일 경우 `guard`다음 코드를 실행한다. 반드시 `else`와 함께 사용해야 하며 `guard` 블록 안에서는 반드시 `return`, `break`, `continue`, `throw` 등으로 종료를 명시해야 한다.

**3.2.3. switch**

`if else`로 간단한 조건식을 나열할 수는 있지만 조건식의 종류가 많아지면 부적절하다. 이런 상황을 해결하기 위해 `switch`를 사용할 수 있다.

```swift
let i = 4
switch i {
case 0:
	print("i is 0")
case 1:
	print("i is 1")

default:
	break
}
```

다른 언어의 `switch`문과 조금 다른점이 몇가지 있다.

- 각 `case`의 `break`는 생략할 수 있다.
- 생략된 `break`는 `fallthrough` 키워드로 취소할 수 있다. 즉, `fallthrough` 키워드를 추가하면 해당 `case`가 끝난 후에 다음 `case`로 넘어간다.
- 모든 경우에 대해 `case`를 작성했을 때 `default case`를 생략할 수 있다.
- 단일 조건이 아닌 range를 `case`로 사용할 수 있다.
- `where` 키워드로 `case`에 부가적인 조건을 추가할 수 있다.

## 4. Swift 함수

함수란 특정한 작업을 위해 호출할 수 있도록 이름을 부여한 코드블록을 말한다. 함수는 호출하는 측으로 부터 매개변수를 받아서 일련의 작업을 완료한 후 다시 호출하는 측으로 값을 반환한다. **메서드(method)**도 함수와 비슷한 특징을 가지고 있지만 특정 클래스나 구조체, 열거형 등에 포함된 함수를 말한다.

### 4.1. 함수 시그니처

함수를 작성하는 문법을 **함수 시그니처(function signature)**라고 하는데, `func`로 시작하는 함수 시그니처는 함수 이름, 매개변수 목록, 반환 타입으로 구성된다.

```swift
func foo(arg: Int) -> Int{
	return 0
}
```

함수 시그니처에서 반환값은 없다면 생략할 수도 있다. 반환값이 없다는 것을 명시하고 싶다면 `-> Void`를 작성할 수도 있다.

```swift
func bar(arg: Int) {
	return
}
```

### 4.2. 매개변수

매개변수는 함수를 호출하면서 전달하는 변수를 말하며, 외부에서 사용하는 이름과 함수 내부에서 사용하는 이름을 모두 부여할 수 있다. 외부 이름은 이름 대신 `_`를 넣어서 생략하지 않으면 호출할 때 이름을 명시해야 하기 때문에 여러개의 매개변수를 전달해야 할 때 유용하다.

```swift
func named(with name: String) {
	// ...
}

named(with: "john")
```

**기본 매개변수(default parameter)**를 지정하면 호출할 때 매개변수를 입력하지 않아도 기본값이 대입된다. 

```swift
func write(content: String = "default content") {
	print(content)
}

write()
// default content
```

함수로 전달되는 매개변수는 기본적으로 함수 내부에서 상수로 취급되기 때문에 값을 변경하고 싶다면 따로 변수로 대입해서 사용해야 한다. 물론 이렇게 shadow copy를 생성해서 변경해도 외부에서는 바뀌지 않기 때문에 내부에서만 변경을 유지할 수 있다. 반대로 외부에서도 변경을 유지하기 위해서 `inout` 키워드로 **입출력 매개변수**를 사용할 수 있다.

```swift
func swap(lhs: inout Int, rhs: inout Int) {
	let temp = lhs
	lhs = rhs
	rhs = temp
}

var a = 10
var b = 20

swap(lhs: &a, rhs: &b)

print("\(a) \(b)")
// 20 10
```

`inout`으로 선언한 매개변수는 변수 즉, `var` 가 되기 때문에 함수를 호출할 때도 `10`, `20` 같은 숫자 리터럴을 전달할 수 없고, `inout`으로 전달한다고 명시하기 위해 `&` 기호를 붙인다.

### 4.3. 함수의 변수화

Swift는 함수형 언어의 특징도 가지고 있기 때문에 함수를 상수나 변수에 대입하는 것도 가능하다. 대입된 변수의 자료형은 함수의 매개변수 목록, 반환 타입으로 정해진다.

```swift
func foo(value: Int) -> Int {
	return value + 10
}

let bar: (Int) -> Int = foo
print(bar(10))
// 20
```

일반 변수 뿐 아니라 매개변수, 반환값으로도 함수를 전달할 수 있으며, 이 특징은 바로 다음에 나올 **클로저(closure)**를 이해하는데 중요하다.

### 4.4. 클로저

정확히 말하면 코드 블록을 뜻하는 **클로저 표현식**, 외부의 변수와 결합된 코드 블록을 뜻하는 **클로저**로 나뉘지만 Swift에서 클로저라는 용어가 널리 쓰이다 보니 두가지 모두 클로저라고 부르게 되었다.

클로저는 이름이 없는 함수를 말하며 오히려 함수가 바로 이름이 있는 클로저라고 할 수 있다. 완료 헨들러로 주로 사용하고, 전달하는 시점에 정보를 유추할 수 있기 때문에 생략된 표현을 사용한다.

```swift
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
```

## 5. Swift 객체지향 프로그래밍

책 SwiftUI 개반의 iOS 프로그래밍 Chapter10 ~ Chapter13의 내용을 다룬다.

객체지향 프로그래밍의 전체 내용은 너무 방대하기 때문에 기본적인 개념과 Swift에서 어떻게 객체지향 프로그래밍을 할 수 있도록 지원하는지 알아본다.

객체 (또는 인스턴스)
프로그램을 구성하는 블록으로 재사용할 수 있는 독립적인 기능 모듈을 말한다.

### 5.1. 클래스

클래스는 객체가 어떤 기능과 내용을 가지고 있는지 정의하는 청사진 이라고 볼 수 있다. 클래스는 `class` 키워드로 시작하는 문법으로 정의할 수 있으며, 내부 내용은 위에서부터 아래 순서로 작성하는 것을 권장한다.

1. 프로퍼티
2. 인스턴스 메서드
3. 타입 메서드

클래스의 이름을 정할 때도 대문자로 시작해야 한다는 규칙을 권장한다.

```swift
class Foo {
	// 1
	let name: String

	// 2
	init(name: String) {
		self.name = name
	}

	// 3
	deinit {
		print("Foo deinitialized")
	}

	func instanceMethod() {
		print("instance method")
	}
	
	// 4
	class func typeMethod() {
		print("type method")
	}
}

let foo = Foo(name: "Foo")
// 5
foo.instanceMethod()
Foo.typeMethod()  // error: static member 'typeMethod' cannot be used on instance of type 'Foo'
Foo.typeMethod()
```

1. 프로퍼티와 인스턴스 메서드는 각 변수를 선언하는 문법과 함수를 선언하는 문법과 같은 문법을 하용한다.
2. `init`이라는 고정된 이름의 생성자를 통해 프로퍼티를 초기화 할 수 있다.
3. `deinit`은 소멸자로 인스턴스가 메모리에서 해제되기 직전에 호출된다.
4. 타입 메소드의 경우 함수 선언부 앞에 `class` 키워드를 추가해서 정의한다. 타입 메소드는 static 메소드이기때문에 인스턴스 메소드처럼 인스턴스를 통해 호출할 수 없고, 클래스 이름을 통해 호출할 수 있다.
5. 인스턴스의 프로퍼티와 메소드는 `.` 키워드로 접근할 수 있다.

**5.1.1. 연산 프로퍼티**

Swift 클래스에는 **저장 프로퍼티**와 **연산 프로퍼티**가 있는데 일반적으로 변수를 선언하는 방법으로 프로퍼티를 선언하면 저장 프로퍼티가 된다. 저장 프로퍼티는 말 그대로 값을 저장하며, 연산 프로퍼티는 값을 설정하거나 가지고오는 시점에 계산을 통해 값을 처리한다. 연산 프로퍼티는 기본적으로 `get` 이라는 getter를 통해 값을 계산하며, 선택적으로 `set` 이라는 setter로 저장 프로퍼티에 새로운 값을 저장하도록 만들 수도 있다.

```swift
class Bar {
	var count: Int = 0
	
	var countPlusTwo: Int {
		get {
			return count + 2
		}
		// 1
		set {
			count = newValue - 2
		}
	}
}

let bar = Bar()
bar.count = 10
print(bar.countPlusTwo)
```

1. setter 에 파라미터 이름을 지정하지 않으면 자동으로 `newValue`에 매치된다.

**5.1.2. 지연 프로퍼티**

기본적으로 프로퍼티는 선언과 동시에 초기화하는 것이 가장 일반적인 방법이다.

```swift
var foo: Int = 10
```

클래스에는 생성자가 있기 때문에 위처럼 바로 초기화하지 않고 생성자에서 초기화하는 것도 가능하다. 

```swift
class Foo {
	var value: Int

	init(initialValue: Int) {
		value = initialValue
	}
}
```

하지만 모든 프로퍼티를 생성자에서 초기화하면 초기화 연산이 복잡한 프로퍼티는 실제로 해당 프로퍼티가 사용되지 않더라도 생성자에서 모두 초기화 되기 때문에 생성자에 너무 많은 연산이 집중된다. 이 때 프로퍼티를 `lazy`로 선언하면 해당 프로퍼티가 최초로 사용될 때만 초기화된다. 즉, 초기화 연산을 분산시킬 수 있다.

```swift
class Foo {
	lazy var complex: String = {
		var result = resourceIntensiveTask()
		result = processData(data: result)
		return result
	}
}
```

지연 프로퍼티는 반드시 `var`로 선언되어야 한다.

### 5.2. 프로토콜

클래스를 구조적으로 만들다 보면 공통으로 가지고 있어야 하는 속성들이 나오게 되는데 이러한 규칙들을 집합으로 모아둔 것을 **프로토콜(protocol)**이라고 한다. 프로토콜은 클래스나 구조체의 선언과 유사하지만 구현부는 작성하지 않고 프로토콜을 채택하는 쪽에 위임한다. 어떤 클래스가 채택한 프로토콜의 모든 요구사항을 충족하지 않으면 에러가 발생한다.

```swift
protocol MessageBuilder {
	var name: String { get }
	func buildMessage() -> String
}
```

아래는 `MessageBuilder` 프로토콜을 채택해서 구현한 `MyMessage` 클래스의 모습이다.

```swift
class MyMessage: MessageBuilder {
	var name: String
	init(name: String) {
		name = name
	}

	func buildMessage() -> String {
		return "MyMessage " + name
	}
}
```

### 5.3. 불투명 반환 타입

프로토콜은 클래스가 채택해서 사용할 수 있는 추상 클래스 개념이라고 했다. **불투명 반환 타입**은 프로토콜을 반환 타입으로 사용할 수 있게 해서 해당 프로토콜을 채택한 어떤 클래스도 반환할 수 있게 해준다.

```swift
func doubleFunc(value: Int) -> some Equatable {
	value * 2
}
```

위 예제에서 `doubleFunc(value:)`는 `Equatable` 프로토콜을 채택한 어떤 타입을 반환할 수 있게 선언되었다. `Int`는 `Equatable` 프로토콜을 채택하고 있는 타입이기 때문에 `value * 2`라는 값을 반환할 수 있다. 불투명 반환 타입을 사용하면 특정 타입을 반환하는 함수를 따로 작성하지 않고 같은 프로토콜을 사용하는 자료형은 하나의 함수로 추상화할 수 있다는 장점이 있다.

불투명 반환 타입은 특히 SwiftUI에서 많이 사용되는 문법이다.

### 5.4. 구조체

class와 비슷하게 여러개의 값을 저장하거나 내부적인 기능을 제공하지만 몇가지 차이점이 있기 때문에 차이점을 인지하고 사용처를 달리 하는 것이 중요하다. class와 마찬가지로 extension을 통해 기능을 확장하거나 protocol을 채택할 수 있지만 가장 큰 차이점은 class는 **reference type**, struct는 **value type**이라는 점이다.

## 6. Reference Type vs Value Type

두 타입의 차이는 대입하거나 함수의 파라미터로 전달할 때 드러난다. reference type은 복사할 때 메모리의 주소가 복사되어 원본을 공유하는 방식이지만 value type은 복사할 때 내용이 전부 복사된 복사본이 생성된다. 즉, class의 인스턴스를 파라미터로 받는 함수 내부에서 값을 변경하면 원래 내용도 바뀌지만, 구조체의 인스턴스를 파라미터로 받는 함수에서 아무리 값을 변경해도 원본에는 변화가 없다.

```swift
class SampleClass {
	var name: String
	
	init(name: String) {
		self.name = name
	}
}

struct SampleStruct {
	var name: String
}

var sampleClass = SampleClass(name: "John")
var sampleStruct = SampleStruct(name: "John")

var copyClass = sampleClass
copyClass.name = "Tomas"
var copyStruct = sampleStruct
copyStruct.name = "Tomas"

print(sampleClass.name)  // Tomas
print(sampleStruct.name)  // John
```

위 예제에서 볼 수 있는 또다른 차이점은 class는 기본 생성자를 제공하지 않아서 프로퍼티를 초기화하는 생성자를 직접 작성해야 하지만 구조체는 프로퍼티를 초기화 할 수 있는 기본 생성자를 제공한다.

일반적으로 구조체가 class 보다 효율적이고, 멀티 스레드 환경에서 더 안정적이기 때문에 상속이나 데이터 캡슐화가 필요한 경우가 아니라면 구조체의 사용을 권장한다. 인스턴스가 해제될 때 추가적인 작업을 할 수 있는 소멸자도 class만 제공한다.

## 7. Swift 서브클래싱

Swift는 클래스 구조를 만들 수 있도록 **상속**과 **확장** 기능을 제공한다.

### 7.1. 상속

상속을 사용하면 공통 기능을 부모 클래스에 정의하고 부모 클래스를 상속 받아 세부 기능을 정의하는 방식으로 구현할 수 있다. **단일 상속** 으로 상속 범위를 제한해서 다중 상속이 가지는 문제를 방지했다.

```swift
class ParentFoo {
	func common() {
		print("this is common function")
	}
}

class SubFoo: ParentFoo {
	func sub() {
		print("this is sub function")
	}
}

class OtherFoo: ParentFoo {
	func other() {
		print("this is other function")
	}
}

let other = OtherFoo()
other.common()
// this is common function
```

`override` 키워드를 사용하면 상속받은 자식 클래스에서 부모 클래스의 함수를 재정의(override)할 수도 있다. 원본 함수의 기능을 사용하지만 추가적인 작업을 위해서 함수를 재정의했다면  `super` 키워드를 통해 원본 함수도 호출해서 두 기능 모두 사용할 수도 있다. 단, 함수를 재정의 할 때는 함수 이름과 매개변수 등 함수 시그니처를 동일하게 작성해야 한다.

```swift
class ParentFoo {
	func common(name: String) {
		print("parent hello \(name)")
	}
}

class SubFoo: ParentFoo {
	override func common(name: String) {
		super.common(name)
		print("sub hello \(name)")
	}
}

let subFoo = SubFoo()
subFoo.common(name: "Gaea")
// parent hello Gaea
// sub hello Gaea
```

자식 클래스에서 생성자도 재정의 할 수 있는데, 인스턴스의 생성 과정에서 발생할 수 있는 잠재적인 문제를 방지하기 위해 프로퍼티를 초기화 하는 순서를 자식 클래스 → 부모 클래스 순서로 강제한다.

```swift
class ParentFoo {
	let name: String
	let number: Int

	init(name: String, number: Int) {
		self.name = name
		self.number = number
	}
}

class SubFoo: ParentFoo {
	let height: Float

	init(name: String, number: Int, height: Float) {
		self.height = height
		super.init(name: name, number: number)
	}
}
```

`SubFoo`의 생성자에서 `height` 프로퍼티를 초기화 하지 않고, `super.init(name: number:)`를 호출하면 컴파일 에러가 발생한다.

### 7.2. 익스텐션 (extension)

Swift는 클래스에 새로운 기능을 추가하는 방법으로 상속과 더불어 **익스텐션(extension)**을 제공한다. 클래스의 이름과 기존 사용성을 유지하면서 새로운 기능만을 추가하고자 할 때 적합한 문법이다. 상속과 달리 기존 함수를 override할 수 없고, 저장 프로퍼티를 추가할 수도 없다.

```swift
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
```

## 8. Swift 프로퍼티 wrapper

 `get`, `set`을 사용하면 캡슐화도 유지하는 동시에 활용성도 높일 수 있기 때문에 `private` stored property를 `public` computed property가 접근하는 방식을 주로 사용했다. 하지만 이렇게 하면 하나의 값을 두개의 프로퍼티가 가지고 있는것이 되고 코드의 양도 두배로 늘어나게 된다. Swift 5.1 부터 `get`, `set`을 사용해서 생기는 이러한 코드의 중복을 줄이는 **프로퍼티 래퍼(Property Wrapper)** 기능을 제공한다.

예를 들어 기존 방식대로 문자열을 저장하는 프로퍼티를 가진 구조체를 생각해보자.

```swift
struct Foo {
	private var storedName: String = ""

	var name: String {
		get { return storedName }
		set { storedName = newValue.uppercased() }
	}
}

var foo = Foo()
foo.name = "london"
print(foo.name)  // LONDON
```

`storedName`의 캡슐화도 유지하면서 `name`으로 `storedName`에 간접 접근할 수 있도록 해서 활용성도 유지할 수 있다. 위 같은 방법으로 대문자로 변환해서 반환하는 연산 프로퍼티가 필요할 경우, 문자열 저장 프로퍼티가 비슷한 이름의 연산 프로퍼티를 가져야 한다. 프로퍼티 래퍼를 사용하면 코드의 중복 없이 동일한 기능을 제공할 수 있다.

먼저 위 `Foo` 구조체를 추상화해서 property wrapper를 만든다. property wrapper는 기본값인 `wrappedValue`라는 값을 가져야 한다. 

```swift
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
```

이제 이 property wrapper를 사용하면 코드의 중복 없이 대문자로 저장해야 하는 프로퍼티를 설정할 때 property wrapper로 간결하게 표현할 수 있다.

```swift
struct Bar {
	@FixCase var name: String
	@FixCase var city: String
	@FixCase var country: String
}

var bar = Bar(name: "gaea", city: "london", country: "korea")
print("\(bar.name) \(bar.city) \(bar.country)")  // GAEA LONDON KOREA
```

위 예제에서는 하나의 값만 래핑하는 property wrapper를 정의했지만 필요에 따라 여러개의 값을 래핑하는 property wrapper를 정의할 수도 있다.

```swift
@propertyWrapper
struct MinMax {
	var value: Int
	let max: Int
	let min: Int

	var wrappedValue: Int {
		get { return value }
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

	init(wrappedValue: Int, min: Int, max: Int) {
		value = wrappedValue
		self.min = min
		self.max = max
	}
}
```

`MinMax` 프로퍼티 래퍼는 `Int`를 최소값 `min`, 최대값 `max` 사이의 값으로 변환한다.

```swift
struct Demo {
	@MinMax(min: 100, max: 300) var value: Int = 100
}

var demo = Demo()
demo.value = 400
print(demo.value)  // 300
```

`MinMax` 프로퍼티 래퍼는 현재 `Int`만 비교할 수 있지만 `Foundation` 프레임워크에 정의된 `Comparable` 프로토콜을 채택한 모든 자료형에 `MinMax`를 적용할 수 있도록 제네릭 프로퍼티 래퍼를 작성할 수도 있다.

```swift
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
```

## 9. Swift 컬렉션

다른 객체들의 집합을 담을 수 있는 객체를 **컬렉션(collection)**이라고 하며, Swift가 제공하는 컬렉션 중 **배열(Array)**과 **딕셔너리(Dictionary)**를 사용하는 방법을 알아본다.

컬렉션은 기본적으로 **가변형(mutable)**과 **불변형(immutable)**이 있다. 두가지는 순서대로 상수(let), 변수(var)에 할당하는 것으로 결정할 수 있다.

### 9.1. 배열

일반적인 다른 언어의 배열은 한가지 자료형을 담을 수 있지만 Swift의 배열은 여러개의 자료형을 한번에 담을 수도 있다. Swift는 타입을 추론할 수 있기 때문에 타입을 명시할 수도 있지만 컴파일러가 추론할 수 있다면 타입을 생략할 수도 있다. 따라서 아래 두 배열은 모두 `[Int]` 배열이다.

```swift
var array: [Int] = [1, 2, 3, 4, 5]
var array2 = [1, 2, 3, 4, 5]
```

Swift 배열은 구조체로 구현되어 있으며, `[]`로 접근하는 기본적인 접근 외에도, 배열을 다룰 수 있는 다양한 기능을 제공한다.

```swift
var trees = ["Pine", "Oak", "Yew"]
print(trees[2])  // Yew
print(trees.count)  // 3
if trees.isEmpty {
	print("empty")
}
```

`count`나 `isEmpty`같은 변수들도 제공하지만 더 복잡한 기능을 가진 함수들도 제공한다.

```swift
let shuffled = trees.shuffled()
let randomTree = trees.randomElement()
```

배열에 새로운 값을 추가하려면 `+=` 연산자를 사용할 수도 있고, `insert(at:)`이나 `append()`같은 함수를 사용할 수 있다. 하나의 값만 추가하는게 아니라 같은 방법으로 배열에 배열을 추가할 수도 있다.

```swift
trees += ["Redwood"]
trees.append(contentsOf: ["Maple", "Birch"])
```

### 9.2. 딕셔너리

배열과 달리 **키-값** 쌍으로 데이터를 저장하는 컬렉션이다. 키는 해당 딕셔너리 내에서 유일한 값을 가지며, 키로 값에 접근하거나 새로운 키-값 쌍을 추가할 수 있다. 배열과 동일하게 타입을 명시하거나 컴파일러가 추론할 수 있도록 작성할 수 있다.

```swift
var dic: [String: Int] = ["gaea": 5, "oasis": 10]
var dic2 = ["gaea": 5, "oasis": 10]
```

마찬가지로 `Dictionary` 또한 구조체로 구현되어 있어서 항목에 접근하거나 수정할 수 있는 다양한 기능을 제공한다. 배열의 인덱스로 접근하는 것 처럼 `[]` 안에 키를 넣어서 값에 접근할 수 있는 연산자도 제공한다. 단 해당 키에 값이 있을 수도 있고, 없을 수도 있기 때문에 딕셔너리에서 꺼내온 값은 대부분 옵셔널이다.

```swift
print(dic["gaea"])  // Optional(5)
dic["gaea"] = 20
print(dic["gaea"])  // Optional(20)
dic.updateValue(30, forKey: "oasis")
print(dic["oasis"])  // Optional(30)
```

딕셔너리의 값은 모두 옵셔널이기 때문에 값에 `nil`을 대입하는 것으로 제거할 수 있다.

```swift
dic["gaea"] = nil
dic.removeValue(forKey: "oasis")
```

## 10. SwiftUI 기초

기존에는 UIKit과 인터페이스 빌더라는 것을 사용해서 iOS 앱을 개발했다. SwiftUI는 선언적 구문, 데이터 주도적인 특징을 사용해서 더 쉽고 빠르게 앱을 개발할 수 있는 방법을 제시한다. 사용자는 단지 화면을 구성하는 컴포넌트들을 선언하고 SwiftUI가 자동으로 레이아웃 위치와 렌더링 방법 등 세부적인 사항을 처리한다. SwiftUI는 데이터 주도적인 특성을 가지고 있기 때문에 데이터가 변경될 때 마다 delegate등을 사용해서 이벤트 처리를 하던 기존 방식과 달리 데이터와 UI가 서로 연결(binding)되어 자동으로 업데이트가 된다.

SwiftUI는 iOS 13 또는 그 이후 버전부터 사용 가능하며 기존 UIKit과 혼용할 수도 있다. SwiftUI가 처음 도입되었을 당시 여전히 AppDelegate나 SceneDelegate 등 스토리보드 기반의 Lifecycle로 개발했지만 최근 SwiftUI 전용 Lifecycle이 추가되었다.

### 10.1. 커스텀 SwiftUI View

SwiftUI를 통해 작업할 때 중요한 포인트 중 하나는 SwiftUI에서 제공하는 View를 가지고 자신만의 커스텀한 View를 만들어서 사용하는 것이다. `View` 프로토콜을 따르는 SwiftUI View는 `body`라는 필수 프로퍼티를 가지고 있다. `body`는 하나의 `View` 객체를 반환할 수 있기 때문에 계층구조로 View를 구성하여 커스텀할 수 있다.

예를 들어 아래 `body`는 두개의 `Text`를 반환하기 때문에 결과적으로 두개의 화면이 만들어진다. `body`는 암묵적인 getter를 사용하고 있기 때문에 명시적으로 둘 중 하나를 `return`하도록 할 수도 있지만 그렇게 하면 나머지 하나는 화면에 추가되지 않는다.

```swift
struct ContentView: View {
	var body: some View {
		Text("Hello")
		Text("world!")
		// return Text("I'm unique")
	}
}
```

하나의 `View` 안에 여러개의 `Text`를 넣으려고 할 때는 `Stack` 등 `View`를 묶어주는 `View`가 필요하다.

```swift
struct ContentView: View {
	var body: some View {
		VStack {
			Text("Hello")
			Text("World")
		}
	}
}
```

SwiftUI의 View는 매우 가볍게 설계되었기 때문에 Apple은 커스텀 뷰를 최대한 작고 가볍게 만들도록 권장한다. 더 작고 모듈화된 뷰를 사용할 수록 더 효율적으로 렌더링할 수 있다. 작은 컴포넌트를 만들기 위해 새로운 `View` struct를 만들 수도 있지만 같은 `View` 안에 커스텀 프로퍼티를 추가해서 사용할 수도 있다.

```swift
struct ContentView: View {
	var title: some View {
		VStack {
			Text("Hello world")
			Text("this is SwiftUI tutorial")
		}
	}
	
	var body: some View {
		VStack {
			title
			Text("content")
		}
	}
}
```

모든 `View`는 속성을 변경할 수 있다. 속성을 변경하는 함수는 변경된 `View`를 반환하기 때문에 메서드 체이닝 방법으로 계속 속성을 변경할 수 있다. 단, 해당 속성이 변경된 상태로 반환된 `View`를 또 변경하기 때문에 순서가 달라지면 결과도 바뀐다.

```swift
struct ContentView: View {
	var body: some View {
		Text("Hello world!")
			.font(.headline)
			.foregroundColor(.red)
	}
}
```

변경할 속성이 공통으로 많다면 변경함수(수정자)를 추상화 해서 하나의 수정자로 만들어서 사용할 수도 있다.

```swift
struct ContentView: View {
	var body: some View {
		Text("StandardTitle")
			.modifier(StandardTitle())
	}
}

struct StandardTitle: ViewModifier {
	func body(content: Content) -> some View {
		content
			.font(.largeTitle)
			.background(Color.white)
			.border(Color.gray, width: 0.2)
			.shadow(color: Color.black, radius: 5, x: 0, y: 5)
	}
}
```

## 11. Stack

SwiftUI는 간단하게 레이아웃을 만들 수 있도록 `VStack`, `HStack`, `ZStack` 3개의 Stack을 제공한다. 이 3개의 Stack을 복합적으로 사용하면 복잡한 레이아웃도 간단하게 작성할 수 있다. 

## 12. SwiftUI with Combine

상태 프로퍼티는 특정 view에 선언되어 `View` 구조체가 data를 포함하고 있다는 한계가 있지만 iOS 13부터 RxSwift와 비슷한 방식으로 상태를 유지할 수 있는 **Combine** 프레임워크가 추가되었다. Combine은 구독 가능한 인스턴스를 만들고 이 인스턴스의 상태가 바뀔 때 마다 모든 구독자(subscriber)들에게 변화된 상태를 전달하여 갱신할 수 있도록 한다. 즉, view와 data를 분리할 수 있다.

```swift
import Foundation
// 1
import Combine

class DemoData: ObservableObject {
	// 2
	@Published var currentUser: String = ""
	@Published var userCount: Int = 0
	
	// 3
	init() {
		updateData()
	}

	// 4
	func updateData() {

	}
}
```

1. Combine 프레임워크를 추가한다.
2. 구독할 수 있는 프로퍼티를 추가한다.
3. 데이터를 초기화 한다.
4. 데이터를 최신 상태로 유지하기 위한 코드를 작성한다.

위 코드는 가장 기본적인 형태로 나타낸 **observable** 객체의 모습이다. view는 이 오브젝트의 인스턴스를 구독하여 view를 동적으로 갱신할 수 있다.

```swift
import SwiftUI

struct ContentView: View {
	// 1
	@ObservedObject var demoData: DemoData

	var body: some View {
		// 2
		Text("\(demoData.currentUser)님, \(demoData.userCount)번째 사용자입니다.")
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		// 3
		ContentView(demoData: DemoData())
	}
}
```

1. `@ObservedObjecct` 래퍼로 observable을 구독할 수 있는 변수를 선언한다.
2. 구독하고 있는 observable 오브젝트의 프로퍼티로 `Text`를 만든다.
3. 프리뷰를 위해 임의로 `DemoData`를 만들어서 전달한다.

### 12.1. EnvironmentObject

`ObservableObject`는 클래스로 ARC에 의해 메모리가 관리되기 때문에 view가 다른 view로 전환되면 인스턴스가 사라지게 된다. 예를 들어 위 예제에서 `ContentView`의 인스턴스가 사라지면 `demoData` 또한 사라지게 된다. 상태 프로퍼티에서 했던 것 처럼 전환되는 다른 view로 인스턴스를 전달할 수도 있지만 구독해야 하는 view가 많아질 수록 복잡해진다.

`ObservableObject`를 여러 view에서 참조해야 할 때 SwiftUI는 인스턴스를 singleton 처럼 전역에서 참조할 수 있는 방법을 제공한다. 특이한 점은 오브젝트를 수정하는게 아니라 참조하는 쪽에서 수정을 해야 한다.

```swift
import SwiftUI

struct ContentView: View {
	// 1
	@EnvironmentObject var demoData: DemoData

	var body: some View {
		Text("\(demoData.currentUser)님, \(demoData.userCount)번째 사용자입니다.")
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		// 2
		ContentView().environmentObject(DemoData())
	}
}
```

1. `@ObservedObject` 대신 `@EnvironmentObject`로 참조한다.
2. view를 만들 때 인스턴스를 직접 전달하지 않고 `environmentObject`로 만들어서 전달한다.

### 12.2. 상태 프로퍼티 (state property)

SwiftUI는 데이터 주도 방식으로 설계되었기 때문에 view에서 직접 업데이트하지 않고, view는 연결(bind)된 데이터의 변화에 따라 자동으로 갱신된다.

`@State` 프로퍼티 래퍼를 통해 데이터를 상태로 나타낼 수 있는 가장 기본적인 형태이다. SwiftUI는 이 상태 프로퍼티의 값이 바뀌는 것을 항상 관측하고 있다가 값이 바뀔 때 마다 view를 다시 화면에 그린다.

```swift
@State private var userName = ""
```

이렇게 초기화 한 상태 프로퍼티는 `$` 연산자로 view에 bind 시킬 수 있다. 

```swift
struct ContentView: View {
	@State private var userName = ""

	var body: some View {
		VStack {
			TextField("이름을 입력하세요", text: $userName)

			Text(userName)
		}
	}
}
```

`userName`이 `TextField`에 연결(bind)되었기 때문에 사용자가 필드에 입력한 값이 아래 `Text`에 나타나게 된다. `Text` 뿐 아니라 다양한 view와 데이터를 바인딩해서 동적인 view를 만들어낼 수 있다.

```swift
struct ContentView: View {
	@State private var wifiEnabled = false

	var body: some View {
		VStack {
			Toggle(isOn: $wifiEnabled) {
				Text("와이파이!")
			}
			
			Image(systemName: wifiEnabled ? "wifi" : "wifi.slash")
		}
	}
}
```

`wifiEnabled` 변수는 `Toggle` view에 바인딩되어 아래에 `Image`가 사용자의 입력에 따라 변하게 된다.

### 12.3. 상태 바인딩

위 예제에서는 같은 `ContentView`안에 view와 상태 프로퍼티가 모두 있어서 문제가 없었지만 화면이 복잡해지게 되면 앞서 했던 것 처럼 임의의 하위 view를 만들어서 view를 구성하게 된다.

```swift
struct ContentView: View {
	@State private var wifiEnabled = false

	var body: some View {
		VStack {
			Toggle(isOn: $wifiEnabled) {
				Text("와이파이!")
			}
			WifiImage()
		}
	}
}

struct WifiImage: View {
	var body: some View {
		// 1
		Image(systemName: wifiEnabled ? "wifi" : "wifi.slash")
	}
}
```

1. `WifiImage`에는 `wifiEnabled`라는 프로퍼티가 없기 때문에 문제가 된다.

위처럼 하위 view에서 상태 프로퍼티를 참조해야 할 경우 `@Binding` 래퍼로 프로퍼티를 프로퍼티에 바인딩할 수 있다.

```swift
			// ...
			WifiImage(flag: $wifiEnabled)
		}
	}
}

struct WifiImage: View {
	@Binding private var flag: Bool

	var body: some View {
		Image(systemName: flag ? "wifi" : "wifi.slash")
	}
}		
```
