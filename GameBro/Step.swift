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
        case 0x00: NOP(implied(4))
        case 0x01: LD(&BC, immediate16(12))
        case 0x02: LD(address: BC, A); implied(8)
        case 0x03: break
        case 0x04: break
        case 0x05: break
        case 0x06: LD(&B, immediate(8))
        case 0x07: break
        case 0x08: break
        case 0x09: break
        case 0x0A: LD(&A, absoluteBC(8))
        case 0x0B: break
        case 0x0C: break
        case 0x0D: break
        case 0x0E: LD(&C, immediate(8))
        case 0x0F: break
        case 0x10: break
        case 0x11: LD(&DE, immediate16(12))
        case 0x12: LD(address: DE, A); implied(8)
        case 0x13: break
        case 0x14: break
        case 0x15: break
        case 0x16: LD(&D, immediate(8))
        case 0x17: break
        case 0x18: break
        case 0x19: break
        case 0x1A: LD(&A, absoluteDE(8))
        case 0x1B: break
        case 0x1C: break
        case 0x1D: break
        case 0x1E: LD(&E, immediate(8))
        case 0x1F: break
        case 0x20: break
        case 0x21: LD(&HL, immediate16(12))
        case 0x22: LD(address: absoluteHLI(8), A)
        case 0x23: break
        case 0x24: break
        case 0x25: break
        case 0x26: LD(&H, immediate(8))
        case 0x27: break
        case 0x28: break
        case 0x29: break
        case 0x2A: LD(&A, address: absoluteHLI(8))
        case 0x2B: break
        case 0x2C: break
        case 0x2D: break
        case 0x2E: LD(&L, immediate(8))
        case 0x2F: break
        case 0x30: break
        case 0x31: LD(&SP, immediate16(12))
        case 0x32: LD(address: absoluteHLD(8), A)
        case 0x33: break
        case 0x34: break
        case 0x35: break
        case 0x36: LD(address: HL, immediate(12))
        case 0x37: break
        case 0x38: break
        case 0x39: break
        case 0x3A: LD(&A, address: absoluteHLD(8))
        case 0x3B: break
        case 0x3C: break
        case 0x3D: break
        case 0x3E: LD(&A, immediate(8))
        case 0x3F: break
        case 0x40: LD(&B, B); implied(4)
        case 0x41: LD(&B, C); implied(4)
        case 0x42: LD(&B, D); implied(4)
        case 0x43: LD(&B, E); implied(4)
        case 0x44: LD(&B, H); implied(4)
        case 0x45: LD(&B, L); implied(4)
        case 0x46: LD(&B, absoluteHL(8))
        case 0x47: LD(&B, A); implied(4)
        case 0x48: LD(&C, B); implied(4)
        case 0x49: LD(&C, C); implied(4)
        case 0x4A: LD(&C, D); implied(4)
        case 0x4B: LD(&C, E); implied(4)
        case 0x4C: LD(&C, H); implied(4)
        case 0x4D: LD(&C, L); implied(4)
        case 0x4E: LD(&C, absoluteHL(8))
        case 0x4F: LD(&C, A); implied(4)
        case 0x50: LD(&D, B); implied(4)
        case 0x51: LD(&D, C); implied(4)
        case 0x52: LD(&D, D); implied(4)
        case 0x53: LD(&D, E); implied(4)
        case 0x54: LD(&D, H); implied(4)
        case 0x55: LD(&D, L); implied(4)
        case 0x56: LD(&D, absoluteHL(8))
        case 0x57: LD(&D, A); implied(4)
        case 0x58: LD(&E, B); implied(4)
        case 0x59: LD(&E, C); implied(4)
        case 0x5A: LD(&E, D); implied(4)
        case 0x5B: LD(&E, E); implied(4)
        case 0x5C: LD(&E, H); implied(4)
        case 0x5D: LD(&E, L); implied(4)
        case 0x5E: LD(&E, absoluteHL(8))
        case 0x5F: LD(&E, A); implied(4)
        case 0x60: LD(&H, B); implied(4)
        case 0x61: LD(&H, C); implied(4)
        case 0x62: LD(&H, D); implied(4)
        case 0x63: LD(&H, E); implied(4)
        case 0x64: LD(&H, H); implied(4)
        case 0x65: LD(&H, L); implied(4)
        case 0x66: LD(&H, absoluteHL(8))
        case 0x67: LD(&H, A); implied(4)
        case 0x68: LD(&L, B); implied(4)
        case 0x69: LD(&L, C); implied(4)
        case 0x6A: LD(&L, D); implied(4)
        case 0x6B: LD(&L, E); implied(4)
        case 0x6C: LD(&L, H); implied(4)
        case 0x6D: LD(&L, L); implied(4)
        case 0x6E: LD(&L, absoluteHL(8))
        case 0x6F: LD(&L, A); implied(4)
        case 0x70: LD(address: HL, B); implied(8)
        case 0x71: LD(address: HL, C); implied(8)
        case 0x72: LD(address: HL, D); implied(8)
        case 0x73: LD(address: HL, E); implied(8)
        case 0x74: LD(address: HL, H); implied(8)
        case 0x75: LD(address: HL, L); implied(8)
        case 0x76: break
        case 0x77: LD(address: HL, A); implied(8)
        case 0x78: LD(&A, B); implied(4)
        case 0x79: LD(&A, C); implied(4)
        case 0x7A: LD(&A, D); implied(4)
        case 0x7B: LD(&A, E); implied(4)
        case 0x7C: LD(&A, H); implied(4)
        case 0x7D: LD(&A, L); implied(4)
        case 0x7E: LD(&A, absoluteHL(8))
        case 0x7F: LD(&A, A); implied(4)
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
        case 0xE0: LDH(offset: immediate(12), A)
        case 0xE1: break
        case 0xE2: LDH(offset: C, A); implied(8)
        case 0xE5: break
        case 0xE6: break
        case 0xE7: break
        case 0xE8: break
        case 0xE9: break
        case 0xEA: LD(address: immediate16(16), A)
        case 0xEE: break
        case 0xEF: break
        case 0xF0: LDH(&A, offset: immediate(12))
        case 0xF1: break
        case 0xF2: LDH(&A, offset: C); implied(8)
        case 0xF3: break
        case 0xF5: break
        case 0xF6: break
        case 0xF7: break
        case 0xF8: break
        case 0xF9: break
        case 0xFA: LD(&A, address: immediate16(16))
        case 0xFB: break
        case 0xFE: break
        case 0xFF: break
        default: fatalError("Invalid opcode")
        }
    }
}