//
//  RepeatingTimer.swift
//  TaskPlanner
//
//  Created by Start on 02/04/2020.
//  Copyright © 2020 Start. All rights reserved.
//
// based on https://medium.com/over-engineering/a-background-repeating-timer-in-swift-412cecfd2ef9
//

import Foundation

class RepeatingTimer {
    
    let timeInterval: TimeInterval
    
    init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }
    
    private lazy var timer: DispatchSourceTimer = {
        let t = DispatchSource.makeTimerSource()
        t.schedule(deadline: .now() + 0.5 , repeating: self.timeInterval)
        t.setEventHandler(handler: { [weak self] in
            self?.eventHandler?()
        })
        return t
    }()
    
    var eventHandler: (() -> Void)?
    
    private enum State {
        case suspended
        case resumed
    }
    private var state: State = .suspended

    deinit {
        timer.setEventHandler {}
        timer.cancel()
        
        /*
        If the timer is suspended, calling cancel without resuming
        triggers a crash. This is documented here https://forums.developer.apple.com/thread/15902
        */
        
        resume()
        eventHandler = nil
    }
    
    func resume() {
        if state == .resumed {
            return
        }
        state = .resumed
        timer.resume()
    }
    
    func suspend() {
        if state == .suspended {
            return
        }
        
        state = .suspended
        timer.suspend()
    }
}

