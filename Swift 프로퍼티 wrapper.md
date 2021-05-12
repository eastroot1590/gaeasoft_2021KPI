# Swift 프로퍼티 wrapper

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