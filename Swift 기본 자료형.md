# Swift 기본 자료형

---

Swift는 **type-safe** 언어이기 때문에 모든 변수는 선언될 때 즉, 컴파일 시점에 컴파일러가 자료형을 추론할 수 있어야 한다. 

## 자료형

기본적으로 정수, 실수, 문자, 문자열 저장할 수 있는 자료형을 가지고 있으며, 같은 정수형 자료형이라도 사용하는 비트 개수에 따라서 `Int32`, `Int16` 등 세부적으로 나뉜 자료형도 지원한다. 

### Bool

참, 거짓을 나타내는 `Bool` 자료형의 경우 `true`, `false` 상수를 지원하기 때문에 코드의 가독성을 더욱 높일 수 있다.

앞서 말했듯이 Swift는 **type-safty**를 굉장히 엄격하게 준수해서 대부분 언어에서 지원하는 **묵시적 캐스팅**을 지원하지 않는다. 즉, `0`은 `false`와 다르게 처리하며, 만약 아래와 같은 조건식을 만든다면 컴파일 에러를 발생시킨다.

```swift
var flag: Int = 0

if (flag) {  // Type 'Int' cannot be used as a boolean; test for '!= 0' instead
	print("flag is no zero.")
}
```

### 정수

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

### 실수

32비트를 사용하는 `Float`, 64비트를 사용하는 `Double`을 제공한다. 정수형과 마찬가지로 두 자료형 모두 실수를 표현하지만 서로 캐스팅 되지 않는다.

### 문자열

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