//
//  UITableView+Extensions.swift
//  TestProject
//
//  Created by Pavan Kumar Valluru on 21.03.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import UIKit

extension UITableView {

    func setMessageOnBackgroundView(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0,
                                                 width: self.bounds.size.width,
                                                 height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .gray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
    }

    func resetBackgroundView() {
        self.backgroundView = nil
    }
}
