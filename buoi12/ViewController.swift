//
//  ViewController.swift
//  buoi12
//
//  Created by LinhMAC on 01/08/2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var redLight: UILabel!
    @IBOutlet weak var yellowLight: UILabel!
    @IBOutlet weak var greenLight: UILabel!
    @IBOutlet weak var redButton: UILabel!
    @IBOutlet weak var yellowButton: UILabel!
    @IBOutlet weak var greenButton: UILabel!
    @IBOutlet weak var redDuration: UITextField!
    @IBOutlet weak var yellowDuration: UITextField!
    @IBOutlet weak var greenredDuration: UITextField!
    var timer: Timer?
    var isRunning: Bool = false
    
    let lightWidth: CGFloat = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        mainImage.frame = CGRect(x: 0, y: 50, width: 400, height: 500)
        mainImage.backgroundColor = .black
        mainImage.center.x = view.center.x
        redLight.frame = CGRect(x: 50,
                                y: 110,
                                width: lightWidth,
                                height: lightWidth)
        redLight.backgroundColor = .red
        redLight.center.x = view.center.x - 10
        redLight.layer.cornerRadius = lightWidth/2
        redLight.layer.masksToBounds = true
        redLight.text = ""
        yellowLight.frame = CGRect(x: 50,
                                   y: redLight.frame.maxY + 55,
                                   width: lightWidth,
                                   height: lightWidth)
        yellowLight.backgroundColor = .yellow
        yellowLight.center.x = view.center.x - 10
        yellowLight.layer.cornerRadius = lightWidth/2
        yellowLight.layer.masksToBounds = true
        greenLight.frame = CGRect(x: 50,
                                  y: yellowLight.frame.maxY+55,
                                  width: lightWidth,
                                  height: lightWidth)
        greenLight.backgroundColor = .green
        greenLight.center.x = view.center.x - 5
        greenLight.layer.cornerRadius = lightWidth/2
        greenLight.layer.masksToBounds = true
        redButton.frame = CGRect(x: 30, y: 800, width: 80, height: 30)
        redButton.backgroundColor = .red
        redButton.layer.cornerRadius = 5
        redButton.layer.masksToBounds = true
        yellowButton.frame = CGRect(x: 30, y: 800, width: 80, height: 30)
        yellowButton.center.x = view.center.x
        yellowButton.backgroundColor = .yellow
        yellowButton.layer.cornerRadius = 5
        yellowButton.layer.masksToBounds = true
        greenButton.frame = CGRect(x: 414-80-30, y: 800, width: 80, height: 30)
        greenButton.backgroundColor = .green
        greenButton.layer.cornerRadius = 5
        greenButton.layer.masksToBounds = true
    }
    
    @IBAction func startButton(_ sender: Any) {
        isRunning = !isRunning
        
        if isRunning {
            startTrafficLight()
            (sender as? UIButton)?.setTitle("Stop", for: .normal)
        } else {
            stopTrafficLight()
            (sender as? UIButton)?.setTitle("Start", for: .normal)
        }
    }
    
    var currentIndex = 0
    var timeRemaining = 0
    
    private func startTrafficLight() {
        // xử lí lỗi nếu không nhâpj giá trị số
        guard let redDurationStr = redDuration.text,
              let yellowDurationStr = yellowDuration.text,
              let greenDurationStr = greenredDuration.text,
              let redDurationValue = Int(redDurationStr),
              let yellowDurationValue = Int(yellowDurationStr),
              let greenDurationValue = Int(greenDurationStr) else {
            return
        }
        
        let lightDurations = [redDurationValue, yellowDurationValue, greenDurationValue]
        
        func updateLightColor() {
            switch currentIndex {
            case 0:
                UIView.animate(withDuration: 1) {
                    self.redLight.backgroundColor = .red
                    self.yellowLight.backgroundColor = .black
                    self.greenLight.backgroundColor = .black
                }
            case 1:
                UIView.animate(withDuration: 1) {
                    self.redLight.backgroundColor = .black
                    self.yellowLight.backgroundColor = .yellow
                    self.greenLight.backgroundColor = .black
                }
            case 2:
                UIView.animate(withDuration: 1) {
                    self.redLight.backgroundColor = .black
                    self.yellowLight.backgroundColor = .black
                    self.greenLight.backgroundColor = .green
                }
            default:
                break
            }
        }
        
        currentIndex = 0
        timeRemaining = lightDurations[currentIndex]
        updateLightColor()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else {
                return
            }
            
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.currentIndex = (self.currentIndex + 1) % lightDurations.count
                self.timeRemaining = lightDurations[self.currentIndex]
                updateLightColor()
            }
        }
        timer?.fire()
    }
    
    private func stopTrafficLight() {
        timer?.invalidate()
        redLight.backgroundColor = .black
        yellowLight.backgroundColor = .black
        greenLight.backgroundColor = .black
    }
}
