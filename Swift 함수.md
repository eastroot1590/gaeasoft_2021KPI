# Swift 함수

함수란 특정한 작업을 위해 호출할 수 있도록 이름을 부여한 코드블록을 말한다. 함수는 호출하는 측으로 부터 매개변수를 받아서 일련의 작업을 완료한 후 다시 호출하는 측으로 값을 반환한다. **메서드(method)**도 함수와 비슷한 특징을 가지고 있지만 특정 클래스나 구조체, 열거형 등에 포함된 함수를 말한다.

## 함수 시그니처

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

## 매개변수

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

## 함수의 변수화

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

## 클로저

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