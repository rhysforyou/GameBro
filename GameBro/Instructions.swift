//
//  Instructions.swift
//  GameBro
//
//  Created by Rhys Powell on 15/03/2016.
//  Copyright © 2016 Rhys Powell. All rights reserved.
//

import Foundation

public extension CPU {
    
    /// `LD nn, n` - 8-bit load into register
    public mutating func LD(inout register: UInt8, _ value: UInt8) {
        register = value
    }
    
    // `LD n, nn` - 16-bit load into register
    public mutating func LD(inout register: UInt16, _ value: UInt16) {
        register = value
    }
    
    /// `LD (C), A` - Write register to memory
    public mutating func LD(address address: Address, _ value: UInt8) {
        memory.write(address, value)
    }
    
    /// `LD A, (C)` - Read memory to register
    public mutating func LD(inout register: UInt8, address: Address) {
        register = memory.read(address)
    }
    
    public mutating func LDH(offset offset: UInt8, _ value: UInt8) {
        let address = Address(0xFF, offset)
        memory.write(address, value)
    }
    
    public mutating func LDH(inout register: UInt8, offset: UInt8) {
        let address = Address(0xFF, offset)
        register = memory.read(address)
    }
    
    public func NOP() {}
    
}
