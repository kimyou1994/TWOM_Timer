//
//  MonsterCell.swift
//  TWOM_Timer
//
//  Created by Young Kim on 6/25/19.
//  Copyright © 2019 Young Jin Kim. All rights reserved.
//

import UIKit
import UserNotifications

class MonsterCell: UITableViewCell {
    
    @IBOutlet weak var monsterImageView: UIImageView!
    @IBOutlet weak var monsterTimer: UILabel!
    @IBOutlet weak var monsterButton: UIButton!
    
    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid
    var spawnTime = 0, state = 0, currentTime = 0, hours = 0, minutes = 0, seconds = 0
    var timer = Timer()
    var name = ""
    
    //Saves necessary data for this particular monster object
    func displayMonster(monster: Monster) {
        spawnTime = monster.respawn
        currentTime = monster.respawn
        name = monster.name!
        monsterImageView.image = monster.image
        convertTime()
    }
    
    //Convert seconds into hh:mm:ss format
    func convertTime() {
        hours = currentTime / 3600
        minutes = (currentTime % 3600) / 60
        seconds = (currentTime % 3600) % 60
        var display = String(hours)
        display += minutes < 10 ? ":0": ":"
        display += String(minutes) + ":"
        display += seconds < 10 ? "0" : ""
        display += String(seconds)
        monsterTimer.text = display
    }
    
    //Counter for timer
    @objc func counter() {
        currentTime -= 1
        convertTime()
        if (currentTime == 0) {
            state = 0
            currentTime = spawnTime
            convertTime()
            monsterButton.setTitle("Start", for: .normal)
            timer.invalidate()
            let content = UNMutableNotificationContent()
            content.title = name + " respawned"
//            content.subtitle = "subtitle"
//            content.body = "body"
            content.badge = 1
            content.sound = UNNotificationSound.default
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            
            let request = UNNotificationRequest(identifier: "TimerDone", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            endBackgroundTask()
        }
    }
    
    //Trigger when start/stop button clicked
    @IBAction func timerClicked(_ sender: Any) {
        if (state == 0) {
            monsterButton.setTitle("Pause", for: .normal)
            state = 1
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(counter), userInfo: nil, repeats: true)
            registerBackgroundTask()
        }else {
            monsterButton.setTitle("Start", for: .normal)
            state = 0
            timer.invalidate()
            convertTime()
            endBackgroundTask()
        }
    }
    //reset timer
    func resetTimer() {
        monsterButton.setTitle("Pause", for: .normal)
        timer.invalidate()
        state = 1
        currentTime = spawnTime
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(counter), userInfo: nil, repeats: true)
        registerBackgroundTask()
    }
    
    //register background task
    func registerBackgroundTask() {
        backgroundTask = UIApplication.shared.beginBackgroundTask {
            [unowned self] in
            self.endBackgroundTask()
        }
        assert(backgroundTask != UIBackgroundTaskIdentifier.invalid)
    }
    
    //ended background task
    func endBackgroundTask() {
        NSLog("Background task ended.")
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = UIBackgroundTaskIdentifier.invalid
    }
    
}
