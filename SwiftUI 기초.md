# SwiftUI 기초

기존에는 UIKit과 인터페이스 빌더라는 것을 사용해서 iOS 앱을 개발했다. SwiftUI는 선언적 구문, 데이터 주도적인 특징을 사용해서 더 쉽고 빠르게 앱을 개발할 수 있는 방법을 제시한다. 사용자는 단지 화면을 구성하는 컴포넌트들을 선언하고 SwiftUI가 자동으로 레이아웃 위치와 렌더링 방법 등 세부적인 사항을 처리한다. SwiftUI는 데이터 주도적인 특성을 가지고 있기 때문에 데이터가 변경될 때 마다 delegate등을 사용해서 이벤트 처리를 하던 기존 방식과 달리 데이터와 UI가 서로 연결(binding)되어 자동으로 업데이트가 된다.

SwiftUI는 iOS 13 또는 그 이후 버전부터 사용 가능하며 기존 UIKit과 혼용할 수도 있다. SwiftUI가 처음 도입되었을 당시 여전히 AppDelegate나 SceneDelegate 등 스토리보드 기반의 Lifecycle로 개발했지만 최근 SwiftUI 전용 Lifecycle이 추가되었다.

## 커스텀 SwiftUI View

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

## Stack

SwiftUI는 간단하게 레이아웃을 만들 수 있도록 `VStack`, `HStack`, `ZStack` 3개의 Stack을 제공한다. 이 3개의 Stack을 복합적으로 사용하면 복잡한 레이아웃도 간단하게 작성할 수 있다.