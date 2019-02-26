//
//  ViewController.swift
//  SpeedTest
//
//  Created by Dhilip on 2/25/19.
//  Copyright © 2019 Dhilip. All rights reserved.
//

import SpeedTestFramework
import UIKit
class ViewController: UIViewController {
  @IBOutlet var speedLabel: UILabel!
  @IBOutlet var summaryLabel: UILabel!
  @IBOutlet var startButton: UIButton!
  @IBOutlet var activityIndicator: UIActivityIndicatorView!
  let speedTestController = SpeedTestController()
  override func viewDidLoad() {
    super.viewDidLoad()
    speedTestController.delegate = self
    speedTestController.configure(url: URL(string: "https://images.apple.com/v/imac-with-retina/a/images/overview/5k_image.jpg")!)
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  @IBAction func startSpeedTest() {
    speedTestController.startTest()
  }
  
  func pauseUI() {
    activityIndicator.startAnimating()
    startButton.isEnabled = false
  }
  
  func resumeUI() {
    activityIndicator.stopAnimating()
    startButton.isEnabled = true
  }
}

extension ViewController: SpeedTestControllerProtocol {
  func speedTestDidStart() {
    pauseUI()
  }
  
  func speedTestDidFail(error: Error?) {
    resumeUI()
  }
  
  func speedTestShow(speed: Double) {
    speedLabel.text = "\(speed.rounded()) MB/s"
  }
  
  func speedTestDidFinish(speed: Double, bytesLength: Int, timeTaken: CFTimeInterval) {
    resumeUI()
    summaryLabel.text = "Bytes :\(bytesLength) \nTime Taken :\(timeTaken.rounded()) s"
  }
}
