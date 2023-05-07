//
//  Haptics.swift
//  People
//
//  Created by Ifeanyi Onuoha on 03/05/2023.
//

import SwiftUI

final class HapticManager {
    static let shared = HapticManager()
    
    private init() {}
    
    func trigger(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        if UserDefaults.standard.bool(forKey: UserDefaultKeys.isHapticOn) {
            let hapticImpact = UIImpactFeedbackGenerator(style: style)
            hapticImpact.impactOccurred()
        }
    }
}
