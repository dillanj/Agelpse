//
//  CreateVC.swift
//  AgeLapse
//
//  Created by Dillan Johnson on 2/27/20.
//  Copyright © 2020 Dillan Johnson. All rights reserved.
//

import UIKit
import MediaPlayer
import AVKit
import SwiftVideoGenerator
import Photos


class CreateVC: UIViewController, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var audioAsset: AVAsset?
    var song: MPMediaItem!
    var photoStore: PhotoStore!
    var imageStore: ImageStore!
    let photoDataSource = PhotoDataSource()
    var videoURL: URL!
    var vc: AVPlayerViewController!
    var player: AVPlayer!

    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var amountLabel: UILabel!
    
    @IBOutlet var addPhotosButton: UIButton!
    
    @IBAction func addMorePhotos(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        
        // check for camera
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBOutlet var addMusicButton: UIButton!
    
    @IBAction func addMusic(_ sender: UIButton) {
        let mediaPickerController = MPMediaPickerController(mediaTypes: .any)
        mediaPickerController.delegate = self
        mediaPickerController.prompt = "Select Audio"
        present(mediaPickerController, animated: true, completion: nil)
    }
    
    @IBOutlet var generateButton: UIButton!
    
    @IBAction func generateButtonClicked(_ sender: Any) {
        generateVideo()
    }
    
    
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // get picked image from info dictionary
        let image = info[.originalImage] as! UIImage
        
        let photo = Photo()
        photoStore.allPhotos.append(photo)
        imageStore.setImage(image, forKey: photo.photoKey)
        _ = photoStore.saveChanges()
        dismiss(animated: true, completion: nil)
        self.viewWillAppear(true)

    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
        let photo = photoDataSource.photos[indexPath.row]
        let image = imageStore.image(forKey: photo.photoKey)
        let identifier = "PhotoCollectionViewCell"
        if let photoCell = cell as? PhotoCollectionViewCell {
            photoCell.update(with: image)
        }
        
//        cell.imageView.image = image
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.amountLabel.text = "\(self.photoStore.allPhotos.count) Photos"
        
        
        collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        self.photoDataSource.photos = photoStore.allPhotos
        self.collectionView.reloadSections(IndexSet(integer: 0))
    }
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        //styling
        addPhotosButton.layer.cornerRadius = 22
        addMusicButton.layer.cornerRadius = 22
        generateButton.layer.cornerRadius = 22
//        collectionView.border.borderColor = UIColor.blue
        collectionView.layer.borderWidth = 0.5
//        collectionView.layer.borderColor = UIColor.blue
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        switch segue.identifier {
        case "showImage"?:
            if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first {
                
                let photo = photoDataSource.photos[selectedIndexPath.row]
                
                let destinationVC = segue.destination as! ImageViewController
//                destinationVC.imageView.image = imageStore.image(forKey: photo.photoKey)
                destinationVC.photo = photo
                destinationVC.imageStore = imageStore
                destinationVC.photoStore = photoStore
            }
            break
        default:
            preconditionFailure("Unexpected segue identifier")
        }
        
    }
    
    func generateVideo() {
      if var audioURL1 = Bundle.main.url(forResource: "xs", withExtension: "mp3") {
        LoadingView.lockView()
        
        VideoGenerator.fileName = "AgeLapse"
        VideoGenerator.shouldOptimiseImageForVideo = true
//        VideoGenerator.scaleWidth = 900
        
        var allImages = [UIImage]()
        for p in self.photoStore.allPhotos {
            if let i = self.imageStore.image(forKey: p.photoKey) {
                allImages.append(i)
            }
        }
        
        if let a = self.song?.assetURL {
            audioURL1 = a
        }
        VideoGenerator.current.generate(withImages: allImages, andAudios: [audioURL1] , andType: .singleAudioMultipleImage, { (progress) in
          print(progress)
        }) { (result) in
          LoadingView.unlockView()
          switch result {
          case .success(let url):
            print(url)
            self.videoURL = url
            self.player = AVPlayer(url: url)
            self.vc = AVPlayerViewController()
            self.vc.player = self.player

            self.present(self.vc, animated: true) {
                self.vc.player?.play()
            }
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: self.videoURL)
            }) { saved, error in
                if saved {
                    let alertController = UIAlertController(title: "Your video was successfully saved", message: nil, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            print("successful")
//            self.createAlertView(message: self.FinishedSingleTypeVideoGeneration)
          case .failure(let error):
            print(error)
            print("unsuccessful")
//            self.createAlertView(message: error.localizedDescription)
          }
        }
      } else {
//        self.createAlertView(message: "Cant Find Audio Files")
        print("cant find audio files")
      }
    }
    
}

extension CreateVC: MPMediaPickerControllerDelegate {
    func mediaPicker(_ mediaPicker: MPMediaPickerController,
                     didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        mediaPicker.showsItemsWithProtectedAssets = false
        mediaPicker.showsCloudItems = false
        
        dismiss(animated: true) {
            let selectedSongs = mediaItemCollection.items
            guard let first_song = selectedSongs.first else { return }
            self.song = first_song
            print("song is: \(first_song.title)")
            print("song has protected assest: \(first_song.hasProtectedAsset)")
            print("song.value is \(first_song.assetURL)")
            let url = first_song.value(forProperty: MPMediaItemPropertyAssetURL) as? URL
            print("song url is: \(url) ")
            self.audioAsset = (url == nil) ? nil : AVAsset(url: url!)
            print("the assest is: \(self.audioAsset)")
            let title = (url == nil) ? "Asset Not Available" : "Asset Loaded"
            let message = (url == nil) ? "Audio Not Loaded" : "Audio Loaded"

            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:nil))
            self.present(alert, animated: true, completion: nil)

        }
    }

    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
      dismiss(animated: true, completion: nil)
    }
}
