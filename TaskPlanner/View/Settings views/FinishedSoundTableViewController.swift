//
//  FinishedSoundTableViewController.swift
//  TaskPlanner
//
//  Created by Start on 02/04/2020.
//  Copyright © 2020 Start. All rights reserved.
//

import UIKit
import AVFoundation

protocol SelectedSoundDelegate {
    func passSelectedSound(selectedSound: Int)
}

class FinishedSoundTableViewController: UITableViewController {

    var delegate: SelectedSoundDelegate?
    var soundPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension FinishedSoundTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Settings.userSettings.sounds.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            resetChecks()
            cell.accessoryType = .checkmark
            delegate?.passSelectedSound(selectedSound: indexPath.row)
        }
        print("\(Settings.userSettings.sounds[indexPath.row])")
        guard let audioFile:URL = Bundle.main.url(forResource: Settings.userSettings.sounds[indexPath.row], withExtension: "wav") else {
            print("Cannot find file")
           
            return
        }
        print(audioFile)
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: audioFile)
            guard let player = soundPlayer else { return }
            player.play()
        } catch let error {
            print("Cannot play sound. \(error.localizedDescription)")
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "finishedSounds", for: indexPath)
        cell.textLabel?.text = Settings.userSettings.sounds[indexPath.row]
        if indexPath.row == Settings.userSettings.selectedSound {
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    // this function was copied, it's simple though.
    func resetChecks() {
        for idx in 0..<tableView.numberOfSections {
            for jdx in 0..<tableView.numberOfRows(inSection: idx) {
                if let cell = tableView.cellForRow(at: IndexPath(row: jdx, section: idx)) {
                    cell.accessoryType = .none
                }
            }
        }
    }
    
  

}
