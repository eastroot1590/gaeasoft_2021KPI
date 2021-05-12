# Swift 객체지향 프로그래밍

책 SwiftUI 개반의 iOS 프로그래밍 Chapter10 ~ Chapter13의 내용을 다룬다.

객체지향 프로그래밍의 전체 내용은 너무 방대하기 때문에 기본적인 개념과 Swift에서 어떻게 객체지향 프로그래밍을 할 수 있도록 지원하는지 알아본다.

객체 (또는 인스턴스)
프로그램을 구성하는 블록으로 재사용할 수 있는 독립적인 기능 모듈을 말한다.

## 클래스

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

### 연산 프로퍼티

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

### 지연 프로퍼티

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

## 프로토콜

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

### 불투명 반환 타입

프로토콜은 클래스가 채택해서 사용할 수 있는 추상 클래스 개념이라고 했다. **불투명 반환 타입**은 프로토콜을 반환 타입으로 사용할 수 있게 해서 해당 프로토콜을 채택한 어떤 클래스도 반환할 수 있게 해준다.

```swift
func doubleFunc(value: Int) -> some Equatable {
	value * 2
}
```

위 예제에서 `doubleFunc(value:)`는 `Equatable` 프로토콜을 채택한 어떤 타입을 반환할 수 있게 선언되었다. `Int`는 `Equatable` 프로토콜을 채택하고 있는 타입이기 때문에 `value * 2`라는 값을 반환할 수 있다. 불투명 반환 타입을 사용하면 특정 타입을 반환하는 함수를 따로 작성하지 않고 같은 프로토콜을 사용하는 자료형은 하나의 함수로 추상화할 수 있다는 장점이 있다.

불투명 반환 타입은 특히 SwiftUI에서 많이 사용되는 문법이다.

## Reference Type vs Value Type

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