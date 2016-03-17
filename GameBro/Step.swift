//
//  Step.swift
//  GameBro
//
//  Created by Rhys Powell on 15/03/2016.
//  Copyright © 2016 Rhys Powell. All rights reserved.
//

import Foundation

extension CPU {
    mutating func step() {
        let opcode: UInt8 = memory.read(PC)
    
        switch opcode {
        case 0x00: NOP(implied(cycles: 4)) // NOP
        case 0x01: LD(&BC, immediate16(cycles: 12)) // LD BC, d16
        case 0x02: LD(address: BC, register(A, cycles: 8)) // LD (BC), A
        case 0x03: break
        case 0x04: break
        case 0x05: break
        case 0x06: LD(&B, immediate(cycles: 8)) // LD B, d8
        case 0x07: break
        case 0x08: break
        case 0x09: break
        case 0x0A: LD(&A, absoluteBC(cycles: 8)) // LD A, (BC)
        case 0x0B: break
        case 0x0C: break
        case 0x0D: break
        case 0x0E: LD(&C, immediate(cycles: 8)) // LD C, d8
        case 0x0F: break
        case 0x10: break
        case 0x11: LD(&DE, immediate16(cycles: 12)) // LD DE, d16
        case 0x12: LD(address: DE, register(A, cycles: 8)) // LD (DE), A
        case 0x13: break
        case 0x14: break
        case 0x15: break
        case 0x16: LD(&D, immediate(cycles: 8)) // LD D, d8
        case 0x17: break
        case 0x18: break
        case 0x19: break
        case 0x1A: LD(&A, absoluteDE(cycles: 8)) // LD A, (DE)
        case 0x1B: break
        case 0x1C: break
        case 0x1D: break
        case 0x1E: LD(&E, immediate(cycles: 8)) // LD E, d8
        case 0x1F: break
        case 0x20: break
        case 0x21: LD(&HL, immediate16(cycles: 12)) // LD HL, d16
        case 0x22: LD(address: absoluteHLI(cycles: 8), A) // LD (HL+), A
        case 0x23: break
        case 0x24: break
        case 0x25: break
        case 0x26: LD(&H, immediate(cycles: 8)) // LD H, d8
        case 0x27: break
        case 0x28: break
        case 0x29: break
        case 0x2A: LD(&A, address: absoluteHLI(cycles: 8)) // LD A, (HL+)
        case 0x2B: break
        case 0x2C: break
        case 0x2D: break
        case 0x2E: LD(&L, immediate(cycles: 8)) // LD L, d8
        case 0x2F: break
        case 0x30: break
        case 0x31: LD(&SP, immediate16(cycles: 12)) // LD SP, d16
        case 0x32: LD(address: absoluteHLD(cycles: 8), A) // LD (HL-), A
        case 0x33: break
        case 0x34: break
        case 0x35: break
        case 0x36: LD(address: HL, immediate(cycles: 12)) // LD (HL), d8
        case 0x37: break
        case 0x38: break
        case 0x39: break
        case 0x3A: LD(&A, address: absoluteHLD(cycles: 8)) // LD A, (HL-)
        case 0x3B: break
        case 0x3C: break
        case 0x3D: break
        case 0x3E: LD(&A, immediate(cycles: 8)) // LD A, d8
        case 0x3F: break
        case 0x40: LD(&B, register(B, cycles: 4)) // LD B, B
        case 0x41: LD(&B, register(C, cycles: 4)) // LD B, C
        case 0x42: LD(&B, register(D, cycles: 4)) // LD B, D
        case 0x43: LD(&B, register(E, cycles: 4)) // LD B, E
        case 0x44: LD(&B, register(H, cycles: 4)) // LD B, H
        case 0x45: LD(&B, register(L, cycles: 4)) // LD B, L
        case 0x46: LD(&B, absoluteHL(cycles: 8))  // LD B, (HL)
        case 0x47: LD(&B, register(A, cycles: 4)) // LD B, A
        case 0x48: LD(&C, register(B, cycles: 4)) // LD C, B
        case 0x49: LD(&C, register(C, cycles: 4)) // LD C, C
        case 0x4A: LD(&C, register(D, cycles: 4)) // LD C, D
        case 0x4B: LD(&C, register(E, cycles: 4)) // LD C, E
        case 0x4C: LD(&C, register(H, cycles: 4)) // LD C, H
        case 0x4D: LD(&C, register(L, cycles: 4)) // LD C, L
        case 0x4E: LD(&C, absoluteHL(cycles: 8))  // LD C, (HL)
        case 0x4F: LD(&C, register(A, cycles: 4)) // LD C, A
        case 0x50: LD(&D, register(B, cycles: 4)) // LD D, B
        case 0x51: LD(&D, register(C, cycles: 4)) // LD D, C
        case 0x52: LD(&D, register(D, cycles: 4)) // LD D, D
        case 0x53: LD(&D, register(E, cycles: 4)) // LD D, E
        case 0x54: LD(&D, register(H, cycles: 4)) // LD D, H
        case 0x55: LD(&D, register(L, cycles: 4)) // LD D, L
        case 0x56: LD(&D, absoluteHL(cycles: 8))  // LD D, (HL)
        case 0x57: LD(&D, register(A, cycles: 4)) // LD D, A
        case 0x58: LD(&E, register(B, cycles: 4)) // LD E, B
        case 0x59: LD(&E, register(C, cycles: 4)) // LD E, C
        case 0x5A: LD(&E, register(D, cycles: 4)) // LD E, D
        case 0x5B: LD(&E, register(E, cycles: 4)) // LD E, E
        case 0x5C: LD(&E, register(H, cycles: 4)) // LD E, H
        case 0x5D: LD(&E, register(L, cycles: 4)) // LD E, L
        case 0x5E: LD(&E, absoluteHL(cycles: 8))  // LD E, (HL)
        case 0x5F: LD(&E, register(A, cycles: 4)) // LD E, A
        case 0x60: LD(&H, register(B, cycles: 4)) // LD H, B
        case 0x61: LD(&H, register(C, cycles: 4)) // LD H, C
        case 0x62: LD(&H, register(D, cycles: 4)) // LD H, D
        case 0x63: LD(&H, register(E, cycles: 4)) // LD H, E
        case 0x64: LD(&H, register(H, cycles: 4)) // LD H, H
        case 0x65: LD(&H, register(L, cycles: 4)) // LD H, L
        case 0x66: LD(&H, absoluteHL(cycles: 8))  // LD H, (HL)
        case 0x67: LD(&H, register(A, cycles: 4)) // LD H, A
        case 0x68: LD(&L, register(B, cycles: 4)) // LD L, B
        case 0x69: LD(&L, register(C, cycles: 4)) // LD L, C
        case 0x6A: LD(&L, register(D, cycles: 4)) // LD L, D
        case 0x6B: LD(&L, register(E, cycles: 4)) // LD L, E
        case 0x6C: LD(&L, register(H, cycles: 4)) // LD L, H
        case 0x6D: LD(&L, register(L, cycles: 4)) // LD L, L
        case 0x6E: LD(&L, absoluteHL(cycles: 8))  // LD L, (HL)
        case 0x6F: LD(&L, register(A, cycles: 4)) // LD L, A
        case 0x70: LD(address: HL, register(B, cycles: 8)) // LD (HL), B
        case 0x71: LD(address: HL, register(C, cycles: 8)) // LD (HL), C
        case 0x72: LD(address: HL, register(D, cycles: 8)) // LD (HL), D
        case 0x73: LD(address: HL, register(E, cycles: 8)) // LD (HL), E
        case 0x74: LD(address: HL, register(H, cycles: 8)) // LD (HL), H
        case 0x75: LD(address: HL, register(L, cycles: 8)) // LD (HL), L
        case 0x76: break
        case 0x77: LD(address: HL, register(A, cycles: 8)) // LD (HL), A
        case 0x78: LD(&A, register(B, cycles: 4)) // LD A, B
        case 0x79: LD(&A, register(C, cycles: 4)) // LD A, C
        case 0x7A: LD(&A, register(D, cycles: 4)) // LD A, D
        case 0x7B: LD(&A, register(E, cycles: 4)) // LD A, E
        case 0x7C: LD(&A, register(H, cycles: 4)) // LD A, H
        case 0x7D: LD(&A, register(L, cycles: 4)) // LD A, L
        case 0x7E: LD(&A, absoluteHL(cycles: 8))  // LD A, (HL)
        case 0x7F: LD(&A, register(A, cycles: 4)) // LD A, A
        case 0x80: break
        case 0x81: break
        case 0x82: break
        case 0x83: break
        case 0x84: break
        case 0x85: break
        case 0x86: break
        case 0x87: break
        case 0x88: break
        case 0x89: break
        case 0x8A: break
        case 0x8B: break
        case 0x8C: break
        case 0x8D: break
        case 0x8E: break
        case 0x8F: break
        case 0x90: break
        case 0x91: break
        case 0x92: break
        case 0x93: break
        case 0x94: break
        case 0x95: break
        case 0x96: break
        case 0x97: break
        case 0x98: break
        case 0x99: break
        case 0x9A: break
        case 0x9B: break
        case 0x9C: break
        case 0x9D: break
        case 0x9E: break
        case 0x9F: break
        case 0xA0: break
        case 0xA1: break
        case 0xA2: break
        case 0xA3: break
        case 0xA4: break
        case 0xA5: break
        case 0xA6: break
        case 0xA7: break
        case 0xA8: break
        case 0xA9: break
        case 0xAA: break
        case 0xAB: break
        case 0xAC: break
        case 0xAD: break
        case 0xAE: break
        case 0xAF: break
        case 0xB0: break
        case 0xB1: break
        case 0xB2: break
        case 0xB3: break
        case 0xB4: break
        case 0xB5: break
        case 0xB6: break
        case 0xB7: break
        case 0xB8: break
        case 0xB9: break
        case 0xBA: break
        case 0xBB: break
        case 0xBC: break
        case 0xBD: break
        case 0xBE: break
        case 0xBF: break
        case 0xC0: break
        case 0xC1: break
        case 0xC2: break
        case 0xC3: break
        case 0xC4: break
        case 0xC5: break
        case 0xC6: break
        case 0xC7: break
        case 0xC8: break
        case 0xC9: break
        case 0xCA: break
        case 0xCB: break
        case 0xCC: break
        case 0xCD: break
        case 0xCE: break
        case 0xCF: break
        case 0xD0: break
        case 0xD1: break
        case 0xD2: break
        case 0xD4: break
        case 0xD5: break
        case 0xD6: break
        case 0xD7: break
        case 0xD8: break
        case 0xD9: break
        case 0xDA: break
        case 0xDC: break
        case 0xDE: break
        case 0xDF: break
        case 0xE0: LDH(offset: immediate(cycles: 12), A) // LD ($FF00+a8), A
        case 0xE1: break
        case 0xE2: LDH(offset: C, register(A, cycles: 8)) // LD ($FF00+C), A
        case 0xE5: break
        case 0xE6: break
        case 0xE7: break
        case 0xE8: break
        case 0xE9: break
        case 0xEA: LD(address: immediate16(cycles: 16), A) // LD (a16), A
        case 0xEE: break
        case 0xEF: break
        case 0xF0: LDH(&A, offset: immediate(cycles: 12)) // LD A, ($FF00+a8)
        case 0xF1: break
        case 0xF2: LDH(&A, offset: register(C, cycles: 8)) // LD A, ($FF00+C)
        case 0xF3: break
        case 0xF5: break
        case 0xF6: break
        case 0xF7: break
        case 0xF8: break
        case 0xF9: break
        case 0xFA: LD(&A, address: immediate16(cycles: 16)) // LD A, (a16)
        case 0xFB: break
        case 0xFE: break
        case 0xFF: break
        default: fatalError("Invalid opcode")
        }
    }
}