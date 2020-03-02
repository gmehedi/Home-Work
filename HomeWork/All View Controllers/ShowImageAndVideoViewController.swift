//
//  ShowImageAndVideoViewController.swift
//  HomeWork
//
//  Created by Mehedi on 2/26/20.
//  Copyright © 2020 MatrixSolution. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Photos
import MobileCoreServices
import Foundation

class ShowImageAndVideoViewController: UIViewController {
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var selectedView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.alertForChooseOption();
        
    }
}
extension ShowImageAndVideoViewController {
    func alertForChooseOption() {
        let alert = UIAlertController(title: "Please", message: "Choose Option", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
           // self.alertForWayOfTakeImage()
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (_) in
                self.goToGallery()
        }))
        alert.addAction(UIAlertAction(title: "Cencel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    //MARK: Alert For Video
    func goToGallery() {
        let alert = UIAlertController(title: "Please", message: "Choose one of them", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Image", style: .default, handler: { (_) in
            self.pickImageFromPhotoLibrary()
        }))
        alert.addAction(UIAlertAction(title: "Video", style: .default, handler: { (_) in
            self.pickVideoFromPhotoLibrary()
        }))
        alert.addAction(UIAlertAction(title: "Cencel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ShowImageAndVideoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func pickImageFromCamera() {
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.sourceType = .camera
                picker.allowsEditing = true
                self.present(picker, animated: true, completion: nil)
            }
    }
    func pickImageFromPhotoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.mediaTypes = [kUTTypeImage as String]
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
        }
    }
    func pickVideoFromPhotoLibrary() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.mediaTypes = [kUTTypeMovie as String]
            picker.allowsEditing = true
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(picker.mediaTypes)
        if (picker.mediaTypes[0] == kUTTypeImage as String){
            guard let presentImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
            }
            //MARK: Set photoImageView to display the selected image.
            self.selectedImageView.image = presentImage
            //MARK: Dismiss the picker.
            dismiss(animated: true, completion: nil)
        }
        else if(picker.mediaTypes[0] == kUTTypeMovie as String ){
            guard let presentVideoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? URL else{
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
            }
       
            //MARK: Video Show In A UIView
            let player = AVPlayer(url: presentVideoUrl)
            // create a video layer for the player
            let layer: AVPlayerLayer = AVPlayerLayer(player: player)
            // make the layer the same size as the container view
            layer.frame = self.selectedView.bounds
            // make the video fill the layer as much as possible while keeping its aspect size
            layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            // add the layer to the container view
            self.selectedView.layer.addSublayer(layer)
            player.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
            player.play()
            dismiss(animated: true, completion: nil)
        }
    }
}
