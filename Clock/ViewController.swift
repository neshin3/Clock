//  ViewController.swift
//  Countdown Timer
//
//  Created by Nestor on 11/10/24.

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!             // Label to show current time
    @IBOutlet weak var countdownPicker: UIDatePicker!   // UIDatePicker to set countdown time
    @IBOutlet weak var startStopButton: UIButton!      // Button to start/stop the timer
    @IBOutlet weak var remainingTimeLabel: UILabel!    // Label to show remaining time
    
    var timer: Timer?
    var isCountingDown = false
    var remainingTime: TimeInterval = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        startClock()
        
        // Configure the date picker for countdown
        countdownPicker.datePickerMode = .countDownTimer
        startStopButton.setTitle("Start", for: .normal)
        
        // Initialize the remaining time label
        remainingTimeLabel.text = "Time Remaining: 00:00"
    }

    // Function to start the clock displaying current time
    func startClock() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E, dd MMM yyyy HH:mm:ss"
            self.timeLabel.text = dateFormatter.string(from: date)
        }
    }

    // Action for starting/stopping the countdown timer
    @IBAction func startStopTimer(_ sender: UIButton) {
        if isCountingDown {
            stopTimer()
        } else {
            // Set remaining time from picker’s selected time
            remainingTime = countdownPicker.countDownDuration
            startTimer()
        }
    }

    // Function to start the countdown timer
    func startTimer() {
        isCountingDown = true
        startStopButton.setTitle("Stop", for: .normal)
        countdownPicker.isUserInteractionEnabled = false
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.updateCountdown()
        }
    }

    // Function to stop the countdown timer
    func stopTimer() {
        isCountingDown = false
        startStopButton.setTitle("Start", for: .normal)
        countdownPicker.isUserInteractionEnabled = true
        timer?.invalidate()
        timer = nil
    }

    // Function to update the countdown timer
    func updateCountdown() {
        if remainingTime > 0 {
            remainingTime -= 1
            countdownPicker.countDownDuration = remainingTime
            updateRemainingTimeLabel()
        } else {
            stopTimer()
            countdownPicker.countDownDuration = 0
            remainingTimeLabel.text = "Time Remaining: 00:00"  // Show "Time Remaining: 00:00" when time is up
        }
    }

    // Helper function to format and update the remaining time label
    func updateRemainingTimeLabel() {
        let minutes = Int(remainingTime) / 60
        let seconds = Int(remainingTime) % 60
        remainingTimeLabel.text = String(format: "Time Remaining: %02d:%02d", minutes, seconds)
    }
}
