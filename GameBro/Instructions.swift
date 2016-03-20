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
    
    /// `LD (C), A` - Write register to memory
    public mutating func LD(address address: Address, _ value: UInt16) {
        memory.write16(address, value)
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
    
    public mutating func LDHL(offset offset: Int8) {
        ZFlag = false
        NFlag = false
        
        let absoluteOffset: Address = Address(abs(offset))
        let address: Address
        
        if (offset >= 0) {
            address = SP &+ absoluteOffset
            CFlag = (SP & 0x00FF) + absoluteOffset > 0xFF
            HFlag = (SP & 0x000F) + absoluteOffset > 0xF
        } else {
            address = SP &- absoluteOffset
            CFlag = (address & 0x00FF) <= (SP & 0x00FF)
            HFlag = (address & 0x000F) <= (SP & 0x000F)
        }
        
        HL = address
    }
    
    public func NOP() {}
    
    public mutating func PUSH(value: UInt16) {
        SP -= 2
        memory.write16(SP, value)
    }
    
    public mutating func POP(inout register: UInt16) {
        register = memory.read16(SP)
        SP += 2
    }
    
}
