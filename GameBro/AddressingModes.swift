//
//  AddressingModes.swift
//  GameBro
//
//  Created by Rhys Powell on 15/03/2016.
//  Copyright © 2016 Rhys Powell. All rights reserved.
//

import Foundation

extension CPU {
    mutating func immediate(cyclesSpent: UInt64) -> UInt8 {
        let operand = memory.read(PC &+ 1)
        
        cycleCount += cyclesSpent
        PC += 2
        
        return operand
    }
}
