//
//  AddressingModes.swift
//  GameBro
//
//  Created by Rhys Powell on 15/03/2016.
//  Copyright © 2016 Rhys Powell. All rights reserved.
//

import Foundation

public extension CPU {
    public mutating func immediate(cyclesSpent: UInt64) -> UInt8 {
        let operand = memory.read(PC &+ 1)
        
        cycle += cyclesSpent
        PC += 2
        
        return operand
    }
    
    public mutating func implied(cyclesSpent: UInt64) {
        cycle += cyclesSpent
        PC += 1
    }
}
