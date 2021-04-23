# Swift 흐름제어

Swift도 프로그램을 어떤 조건에 실행하고, 얼마나 반복할지 제어하는 흐름제어 문법을 제공한다. 흐름제어는 반복을 제어하는 **반복 제어(looping control)**과 조건에 따라 실행을 제어하는 **조건부 제어 흐름(conditional flow control)**이 있다.

## 반복 제어

말 그대로 프로그램의 반복을 제어한다.

### for in

`for in` 문법은 앞서 배운 range를 기반으로 range의 각 인덱스를 상수에 대입하면서 반복을 수행한다. 

```swift
for i in 1...5 {
	// 반복
}
```

범위는 collection 또는 range가 될 수 있고, `String`도 범위로 사용할 수 있어서 `String`을 구성하는 각 문자 개수만큼 반복할 수 있다. `for in` 안에서 range 인덱스 상수를 사용할 필요가 없다면 `_`로 이름을 생략할 수도 있다.

### while

반복 횟수를 알고 있어야 하는 `for in`과 달리 `while`은 조건식이 참일 동안 반복한다. 반복을 돌면서 조건식을 검사한다.

### repeat while

Swift 1.x의 `do while`이 변형된 문법으로 `while`과 비슷하지만 조건식의 검사를 마지막에 수행한다는 점이 다르다. 때문에 구문 안에 코드는 최초 1회는 조건식의 참/거짓에 관계없이 실행된다.

```swift
var i = -10
repeat {
	i += 5
} while i > 0
// i is -5
```

### break

반복문의 횟수를 채우거나 반복 조건에 만족하지 않아도 반복을 종료하고 싶을 때 `break`로 빠져나올 수 있다.

### continue

반복 도중에 남은 코드를 건너뛰고 다시 처음부터 실행하고 싶을 때 `continue`를 사용해서 건너뛸 수 있다.

## 조건부 흐름 제어

조건에 따라 프로그램의 흐름을 제어한다.

### if

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

### guard

Swift 2.x 부터 도입된 기능으로 조건식이 참일 경우 `guard`다음 코드를 실행한다. 반드시 `else`와 함께 사용해야 하며 `guard` 블록 안에서는 반드시 `return`, `break`, `continue`, `throw` 등으로 종료를 명시해야 한다.

### switch

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