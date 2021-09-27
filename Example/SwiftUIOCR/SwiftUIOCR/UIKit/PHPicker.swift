//
//  PHPicker.swift
//  SwiftUIOCR
//
//  Created by 이동근 on 2021/09/27.
//

import SwiftUI
import PhotosUI

struct PHPicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode)
    private var presentationMode
    
    let sourceType: UIImagePickerController.SourceType
    let onImagePicked: (UIImage) -> Void
    
    final class Coordinator: PHPickerViewControllerDelegate {
        @Binding
        private var presentationMode: PresentationMode
        private let sourceType: UIImagePickerController.SourceType
        private let onImagePicked: (UIImage) -> Void
        
        init(presentationMode: Binding<PresentationMode>, sourceType: UIImagePickerController.SourceType, onImagePicked: @escaping (UIImage) -> Void) {
            _presentationMode = presentationMode
            self.sourceType = sourceType
            self.onImagePicked = onImagePicked
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            print(results)
//            parent.isPresented = false // Set isPresented to false because picking has finished.
//            picker.dismiss(animated: true, completion: nil)
            
            let identifiers = results.compactMap(\.assetIdentifier)
            let fetchResult = PHAsset.fetchAssets(withLocalIdentifiers: identifiers, options: nil)
            if let selectedAsset = fetchResult.firstObject {
                let manager = PHImageManager()
                let option = PHImageRequestOptions()
                option.deliveryMode = .highQualityFormat
                manager.requestImage(for: selectedAsset, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: option, resultHandler: { image, error in
                    if let selectedImage = image {
                        self.onImagePicked(selectedImage)
                    }
                })
            }
            
            presentationMode.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(presentationMode: presentationMode, sourceType: sourceType, onImagePicked: onImagePicked)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.selectionLimit = 1
        config.filter = .images
        config.preferredAssetRepresentationMode = .current
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = PHPickerViewController
    
    
}

