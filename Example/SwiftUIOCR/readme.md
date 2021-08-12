# SwiftUIOCR

기존 Storyboard 기반 Swift로 개발한 **OCRScanner** 샘플을 SwiftUI로 개발한다.

## 기획

- 사진 라이브러리에서만 이미지를 선택할 수 있도록 한다.
- Kakao Vision, Google ML Vision 중 선택해서 이미지를 인식할 수 있도록 한다.
- 문자가 인식되면 인식된 결과를 보여주는 화면으로 이동한다.
- 인식 결과는 **인식된 문자** 뿐 아니라 해당 문자를 인식한 **위치**도 네모 박스로 보여질 수 있도록 한다.
- (추가) 결과 화면에서 박스를 터치하면 해당 박스에서 인식한 단어가 박스 옆에 표시될 수 있도록 한다.

## 구현

### UIImagePicker 연동

SwiftUI에서 UIKit을 사용하기 위해서는 `UIViewControllerRepresentable`를 상속받는 `View`를 추가로 만들어서 해당 프로토콜에 맞춰서 몇가지 코드를 추가해야 한다.

먼저 `UIViewControllerType`에 사용하려고 하는 UIKit 클래스 타입을 지정한다.

```swift
	typealias UIViewControllerType = UIImagePickerController
```

그리고 위에서 설정한 타입의 `ViewController`를 사용하기 위한 delegate 함수를 추가한다.

```swift
func makeUIViewController(context: UIViewControllerRepresentableContext<PhotoPicker>) -> UIImagePickerController {
	// 사용하려고 하는 ViewController를 생성해서 리턴
}

func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<PhotoPicker>) {
	// ViewController가 업데이터 되었을 때 이벤트 처리
}
```

`UIImagePicker`를 사용하기 때문에 `makeUIViewController` 함수에서 `UIImagePicker`를 생성하는 코드를 작성한다.

```swift
func makeUIViewController(context: UIViewControllerRepresentableContext<PhotoPicker>) -> UIImagePickerController {
	let picker = UIImagePickerController()
	return picker
}
```

`UIImagePickerController`는 사용자가 사진을 선택했다는 이벤트를 처리하기 위해 delegate를 사용하는데, 기존 UIKit에서 delegate, dataSource 등을 SwiftUI에서 사용하려면 **Coordinator**라는 새로운 패턴을 써야 한다. 이 패턴은 `UIViewControllerRepresentable`에 있는 `Coordinator`라는 클래스를 사용하기 때문에 해당 클래스의 구현과 `makeCoordinator` 함수를 정의한다. 정의하지 않으면 `context.coordinator`는 `Void` 타입이 되어 사용할 수 없다.

```swift
	// in struct ImagePicker: UIViewControllerRepresentable
	final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
		@Binding
		private var presentationMode: PresentationMode
		private let sourceType: UIImagePickerController.SourceType
		private let onImagePicked: (UIImage) -> Void
		
		init(presentationMode: Binding<PresentationMode>, sourceType: UIImagePickerController.SourceType, onImagePicked: @escaping (UIImage) -> Void) {
			_presentationMode = presentationMode
			self.sourceType = sourceType
			self.onImagePicked = onImagePicked
		}
		
		func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
			let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
			onImagePicked(uiImage)
			presentationMode.dismiss()
		}
		
		func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
			presentationMode.dismiss()
		}
	}

	// makeUIViewController가 호출되기 전에 호출된다.
	func makeCoordinator() -> Coordinator {
		return Coordinator(presentationMode: presentationMode, sourceType: sourceType, onImagePicked: onImagePicked)
	}
```

`Coordinator`를 만들었다면 `makeUIViewController()`에서 delegate를 `coordinator`로 설정할 수 있다.

```swift
func makeUIViewController(context: UIViewControllerRepresentableContext<PhotoPicker>) -> UIImagePickerController {
	let picker = UIImagePickerController()
	picker.dataSource = dataSource
	picker.delegate = context.coordinator
	return picker
}
```
