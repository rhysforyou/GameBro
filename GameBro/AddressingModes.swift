//
//  AddressingModes.swift
//  GameBro
//
//  Created by Rhys Powell on 15/03/2016.
//  Copyright © 2016 Rhys Powell. All rights reserved.
//

import Foundation

public extension CPU {
    public mutating func absoluteBC(cyclesSpent: UInt64) -> UInt8 {
        let operand = memory.read(BC)
        
        cycle += cyclesSpent
        PC += 1
        
        return operand
    }
    
    public mutating func absoluteDE(cyclesSpent: UInt64) -> UInt8 {
        let operand = memory.read(DE)
        
        cycle += cyclesSpent
        PC += 1
        
        return operand
    }
    
    public mutating func absoluteHL(cyclesSpent: UInt64) -> UInt8 {
        let operand = memory.read(HL)
        
        cycle += cyclesSpent
        PC += 1
        
        return operand
    }
    
    public mutating func absoluteHLD(cyclesSpent: UInt64) -> Address {
        let address = Address(HL)
        HL -= 1
        
        cycle += cyclesSpent
        PC += 1
        
        return address
    }
    
    public mutating func absoluteHLI(cyclesSpent: UInt64) -> Address {
        let address = Address(HL)
        HL += 1
        
        cycle += cyclesSpent
        PC += 1
        
        return address
    }
    
    public mutating func immediate(cyclesSpent: UInt64) -> UInt8 {
        let operand = memory.read(PC &+ 1)
        
        cycle += cyclesSpent
        PC += 2
        
        return operand
    }
    
    public mutating func immediate16(cyclesSpent: UInt64) -> UInt16 {
        let low  = memory.read(PC &+ 1)
        let high = memory.read(PC &+ 2)
        let operand = UInt16(high) << 8 | UInt16(low)
        
        cycle += cyclesSpent
        PC += 3
        
        return operand
    }
    
    public mutating func implied(cyclesSpent: UInt64) {
        cycle += cyclesSpent
        PC += 1
    }
    
    public mutating func register(register: UInt8, _ cyclesSpent: UInt64) -> UInt8 {
        cycle += cyclesSpent
        PC += 1
        
        return register
    }
}
