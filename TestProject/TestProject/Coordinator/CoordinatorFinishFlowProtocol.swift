//
//  CoordinatorFinishOutput.swift
//  TestProject
//
//  Created by Pavan Kumar Valluru on 21.03.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import Foundation

protocol CoordinatorFinishFlow {
    var finishFlow: (() -> Void)? { get set }
}
