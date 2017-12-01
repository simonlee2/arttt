//
//  StatusView.swift
//  arttt
//
//  Created by Shao-Ping Lee on 10/9/17.
//  Copyright © 2017 Simon Lee. All rights reserved.
//

import UIKit

class StatusView: UIVisualEffectView {
    var currentStatus: String?
    var queuedStatus: String?
    var timer: Timer?
    
    func queueStatus(_ status: String) {
        queuedStatus = status
        if currentStatus == nil {
            showNextStatus()
        }
    }
    
    func showNextStatus() {
        // Update variables
        currentStatus = queuedStatus
        queuedStatus = nil
        
        // if no queued status, fade out
        guard currentStatus != nil else {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: { [unowned self] in
                    self.alpha = 0.0
                }, completion: nil)
            return
        }
        
        // Update label with queued status
        guard let label = contentView.subviews.first as? UILabel else { return }
        label.text = currentStatus
        
        // Animate
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: { [unowned self] in
            self.alpha = 1.0
        }, completion: { [unowned self] finished in
            self.timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: false, block: { [unowned self] _ in
                self.showNextStatus()
            })
        })
    }
}
