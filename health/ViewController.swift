//
//  ViewController.swift
//  health
//
//  Created by Arthur Trampnau on 25/01/25.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    let pedometer = CMPedometer()
        var totalSteps: Int = 0
        
        override func viewDidLoad() {
            super.viewDidLoad()
            startPedometerUpdates()
        }
        
        func startPedometerUpdates() {
            guard CMPedometer.isStepCountingAvailable() else {
                print("Step counting isn't available")
                return
            }
            
            let now = Date()
            pedometer.startUpdates(from: now) { [weak self] data, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async {
                    let steps = data.numberOfSteps.intValue
                    self?.totalSteps = steps
                    self?.updateLabels()
                }
            }
        }
        
        func updateLabels() {
            let calories = Double(totalSteps) * 0.05
            stepsLabel.text = "Steps: \(totalSteps)"
            caloriesLabel.text = String(format: "kcal: %.2f", calories)
            }
        @IBAction func resetButtonTapped(_ sender: UIButton) {
            pedometer.stopUpdates()
            totalSteps = 0
            updateLabels()
            startPedometerUpdates()
        }
}
        
    
