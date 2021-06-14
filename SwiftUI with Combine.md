# SwiftUI with Combine

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

## EnvironmentObject

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