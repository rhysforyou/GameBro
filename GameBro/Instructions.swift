//
//  Instructions.swift
//  GameBro
//
//  Created by Rhys Powell on 15/03/2016.
//  Copyright © 2016 Rhys Powell. All rights reserved.
//

import Foundation

public extension CPU {
    
    internal mutating func spendCycles(count: UInt64) {
        cycleCount = cycleCount + count
    }
    
    /// `LD` r1, r2 - Load into register
    public mutating func LD(inout register: UInt8, _ value: UInt8) {
        spendCycles(4)
        register = value
    }
    
    /// `LD A, (C)` - Read memory to register
    public mutating func LD(inout register: UInt8, _ address: Address) {
        spendCycles(8)
        register = memory.read(address)
    }
    
    /// `LD (C), A` - Write register to memory
    public mutating func LD(address: Address, _ value: UInt8) {
        spendCycles(8)
        memory.write(address, value)
    }
}
