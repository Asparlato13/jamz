//
//  HapticsManger.swift
//  JamzApp
//
//  Created by Adrianna Parlato on 10/11/22.
//

import Foundation
import UIKit


final class HapticsManager {
    static let shared = HapticsManager()
    
    private init() {
        
    }
    
    public func vibrateForSelection() {
        DispatchQueue.main.async {
            let generator = UISelectionFeedbackGenerator()
            generator.prepare()
            generator.selectionChanged()
        }
    }
    
    public func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        DispatchQueue.main.async {
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(type)
        }
    }
}



