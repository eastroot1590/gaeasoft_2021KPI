# Swift 서브클래싱

Swift는 클래스 구조를 만들 수 있도록 **상속**과 **확장** 기능을 제공한다.

## 상속

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

## 익스텐션 (extension)

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