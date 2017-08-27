//
//  NotificationFeedbackProtocol.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 8/27/17.
//  Copyright © 2017 SomeSimpleSolutions. All rights reserved.
//

import UIKit

protocol NotificationFeedbackProtocol: HapticFeedbackProtocol {
    func notificationOccurred(_ notificationType: UINotificationFeedbackType)
}
