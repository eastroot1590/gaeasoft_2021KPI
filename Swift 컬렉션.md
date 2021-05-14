# Swift 컬렉션

다른 객체들의 집합을 담을 수 있는 객체를 **컬렉션(collection)**이라고 하며, Swift가 제공하는 컬렉션 중 **배열(Array)**과 **딕셔너리(Dictionary)**를 사용하는 방법을 알아본다.

컬렉션은 기본적으로 **가변형(mutable)**과 **불변형(immutable)**이 있다. 두가지는 순서대로 상수(let), 변수(var)에 할당하는 것으로 결정할 수 있다.

## 배열

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

## 딕셔너리

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