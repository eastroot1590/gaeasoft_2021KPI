# SwiftUI 상태 프로퍼티

SwiftUI는 데이터 주도 방식으로 설계되었기 때문에 view에서 직접 업데이트하지 않고, view는 연결(bind)된 데이터의 변화에 따라 자동으로 갱신된다.

## 상태 프로퍼티 (state property)

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

## 상태 바인딩

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