//
//  ViewController.swift
//  FFMpeg-Example
//
//  Created by Kaymun Amin on 2019-11-24.
//  Copyright © 2019 Touhid Apps. All rights reserved.
//

import UIKit
import mobileffmpeg
import MobileCoreServices
import Photos
import AVKit
import AVFoundation

class ViewController: UIViewController, UINavigationControllerDelegate {
    
    var controller = UIImagePickerController()
    var videoFilePath1 = ""
    var videoFilePath2 = ""
    var videoFilePathDuet = ""
    var whichVideo = 0
    
    @IBOutlet var player1: VideoView!
    
    @IBOutlet var player2: VideoView!
    
    @IBOutlet var playerDuet: VideoView! // side by side
    
    @IBAction func takeVideo1(_ sender: UIButton) {
        whichVideo = 1
        videoTake()
    }
    
    @IBAction func takeVideo2(_ sender: UIButton) {
        whichVideo = 2
        videoTake()
    }
    
    @IBAction func processDuet(_ sender: UIButton) {
        DispatchQueue.global().async {
            
            let randomNum = Int.random(in: 0..<100)
            
            guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
            let destination = documentsDirectory.appendingPathComponent("myDuetVideo-\(randomNum).mov")


            print("ddddd \(destination)")
            
            MobileFFmpeg.execute("-i \(self.videoFilePath1) -i \(self.videoFilePath2) -filter_complex hstack \(destination)")
            
            let rc = MobileFFmpeg.getLastReturnCode()
            let output = MobileFFmpeg.getLastCommandOutput()
            let mi = MobileFFmpeg.getMediaInformation(destination.absoluteString)
            if (rc == RETURN_CODE_SUCCESS) {
                print("Command execution completed successfully.\n")
                print("a \(mi?.getFormat())")
                print("b \(mi?.getPath())")
                print("c \(mi?.getBitrate())")
                print("d \(mi?.getRawInformation())")
                print("e \(mi?.getDuration())")
                
                let videoData = try? Data(contentsOf: destination)
                let paths = NSSearchPathForDirectoriesInDomains(
                    FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
                let documentsDirectory: URL = URL(fileURLWithPath: paths[0])
                let dataPath = documentsDirectory.appendingPathComponent("videoOutput-\(randomNum).mp4")
                try! videoData?.write(to: dataPath, options: [])
                print("Data path:m\(dataPath)")
                
                self.videoFilePathDuet = "\(dataPath)"
                self.playerDuet.configure(url: "\(dataPath)")
                self.playerDuet.isLoop = false
                self.playerDuet.play()
                
            } else if (rc == RETURN_CODE_CANCEL) {
                print("Command execution cancelled by user.\n")
            } else {
                print("Command execution failed with rc=\(rc) and output=\(String(describing: output)).\n")
            }
            
        }
    }
    
    @IBAction func play1(_ sender: UIButton) {
        player1.configure(url: "\(videoFilePath1)")
        player1.isLoop = false
        player1.play()
    }
    
    @IBAction func play2(_ sender: UIButton) {
        player2.configure(url: "\(videoFilePath2)")
        player2.isLoop = false
        player2.play()
    }
    
    @IBAction func playDuet(_ sender: UIButton) {
        playerDuet.configure(url: "\(videoFilePathDuet)")
        playerDuet.isLoop = false
        playerDuet.play()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    } // viewDidLoad
    
    func videoTake() {
        // 1 Check if project runs on a device with camera available
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            // 2 Present UIImagePickerController to take video
            controller.sourceType = .camera
            controller.mediaTypes = [kUTTypeMovie as String]
            controller.delegate = self
            
            present(controller, animated: true, completion: nil)
        }
        else {
            print("Camera is not available")
        }
    } // videoTake
    
    @objc func videoSaved(_ video: String, didFinishSavingWithError error: NSError!, context: UnsafeMutableRawPointer){
        if let theError = error {
            print("error saving the video = \(theError)")
        } else {
            DispatchQueue.main.async(execute: { () -> Void in
               //fdd
            })
        }
    }
    
}

extension ViewController: UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let randomNum = Int.random(in: 0..<100)

        // 1
        if let selectedVideo:URL = (info[UIImagePickerController.InfoKey.mediaURL] as? URL) {
            // Save video to the main photo album
            let selectorToCall = #selector(ViewController.videoSaved(_:didFinishSavingWithError:context:))
            
            // 2
            UISaveVideoAtPathToSavedPhotosAlbum(selectedVideo.relativePath, self, selectorToCall, nil)
            // Save the video to the app directory
            let videoData = try? Data(contentsOf: selectedVideo)
            let paths = NSSearchPathForDirectoriesInDomains(
                FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
            let documentsDirectory: URL = URL(fileURLWithPath: paths[0])
            let dataPath = documentsDirectory.appendingPathComponent("videoMain--\(randomNum).mp4")
            try! videoData?.write(to: dataPath, options: [])
            print("Data path:m\(dataPath)")
            
            
            if self.whichVideo == 1 {
                self.videoFilePath1 = "\(dataPath)"
                print("Video1: \(dataPath)")
                player1.configure(url: "\(dataPath)")
                player1.isLoop = true
                player1.play()
            } else if self.whichVideo == 2 {
                self.videoFilePath2 = "\(dataPath)"
                print("Video2: \(dataPath)")
                player2.configure(url: "\(dataPath)")
                player2.isLoop = true
                player2.play()
            }
            
            
        }
        // 3
        picker.dismiss(animated: true)
    }
}
