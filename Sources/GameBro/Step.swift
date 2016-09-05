extension CPU {

    /// Perform the instruction at the program counter
    mutating func step() {
        let opcode: UInt8 = memory.read(PC)

        switch opcode {
        case 0x00: NOP(implied(cycles: 4)) // NOP
        case 0x01: LD(&BC, immediate16(cycles: 12)) // LD BC, d16
        case 0x02: LD(address: BC, register(A, cycles: 8)) // LD (BC), A
        case 0x03: break
        case 0x04: INC(&B); implied(cycles: 4) // INC B
        case 0x05: DEC(&B); implied(cycles: 4) // DEC B
        case 0x06: LD(&B, immediate(cycles: 8)) // LD B, d8
        case 0x07: break
        case 0x08: LD(address: immediate16(cycles: 20), SP)
        case 0x09: break
        case 0x0A: LD(&A, absoluteBC(cycles: 8)) // LD A, (BC)
        case 0x0B: break
        case 0x0C: INC(&C); implied(cycles: 4) // INC C
        case 0x0D: DEC(&D); implied(cycles: 4) // DEC C
        case 0x0E: LD(&C, immediate(cycles: 8)) // LD C, d8
        case 0x0F: break
        case 0x10: break
        case 0x11: LD(&DE, immediate16(cycles: 12)) // LD DE, d16
        case 0x12: LD(address: DE, register(A, cycles: 8)) // LD (DE), A
        case 0x13: break
        case 0x14: INC(&D); implied(cycles: 4) // INC D
        case 0x15: DEC(&D); implied(cycles: 4) // DEC D
        case 0x16: LD(&D, immediate(cycles: 8)) // LD D, d8
        case 0x17: break
        case 0x18: break
        case 0x19: break
        case 0x1A: LD(&A, absoluteDE(cycles: 8)) // LD A, (DE)
        case 0x1B: break
        case 0x1C: INC(&E); implied(cycles: 4) // INC E
        case 0x1D: DEC(&E); implied(cycles: 4) // DEC E
        case 0x1E: LD(&E, immediate(cycles: 8)) // LD E, d8
        case 0x1F: break
        case 0x20: break
        case 0x21: LD(&HL, immediate16(cycles: 12)) // LD HL, d16
        case 0x22: LD(address: absoluteHLI(cycles: 8), A) // LD (HL+), A
        case 0x23: break
        case 0x24: INC(&H); implied(cycles: 4) // INC H
        case 0x25: DEC(&H); implied(cycles: 4) // DEC H
        case 0x26: LD(&H, immediate(cycles: 8)) // LD H, d8
        case 0x27: break
        case 0x28: break
        case 0x29: break
        case 0x2A: LD(&A, address: absoluteHLI(cycles: 8)) // LD A, (HL+)
        case 0x2B: break
        case 0x2C: INC(&L); implied(cycles: 4) // INC L
        case 0x2D: DEC(&L); implied(cycles: 4) // DEC L
        case 0x2E: LD(&L, immediate(cycles: 8)) // LD L, d8
        case 0x2F: break
        case 0x30: break
        case 0x31: LD(&SP, immediate16(cycles: 12)) // LD SP, d16
        case 0x32: LD(address: absoluteHLD(cycles: 8), A) // LD (HL-), A
        case 0x33: break
        case 0x34: INC(address: immediate16(cycles: 12)) // INC (a16)
        case 0x35: DEC(address: immediate16(cycles: 12)) // DEC (a16)
        case 0x36: LD(address: HL, immediate(cycles: 12)) // LD (HL), d8
        case 0x37: break
        case 0x38: break
        case 0x39: break
        case 0x3A: LD(&A, address: absoluteHLD(cycles: 8)) // LD A, (HL-)
        case 0x3B: break
        case 0x3C: INC(&A); implied(cycles: 4) // INC A
        case 0x3D: DEC(&A); implied(cycles: 4) // DEC A
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
        case 0x80: ADD(&A, register(B, cycles: 4)) // ADD A, B
        case 0x81: ADD(&A, register(C, cycles: 4)) // ADD A, C
        case 0x82: ADD(&A, register(D, cycles: 4)) // ADD A, D
        case 0x83: ADD(&A, register(E, cycles: 4)) // ADD A, E
        case 0x84: ADD(&A, register(H, cycles: 4)) // ADD A, H
        case 0x85: ADD(&A, register(L, cycles: 4)) // ADD A, L
        case 0x86: ADD(&A, address: register16(HL, cycles: 8)) // ADD A, (HL)
        case 0x87: ADD(&A, register(A, cycles: 4)) // ADD A, A
        case 0x88: ADC(&A, register(B, cycles: 4)) // ADC A, B
        case 0x89: ADC(&A, register(C, cycles: 4)) // ADC A, C
        case 0x8A: ADC(&A, register(D, cycles: 4)) // ADC A, D
        case 0x8B: ADC(&A, register(E, cycles: 4)) // ADC A, E
        case 0x8C: ADC(&A, register(H, cycles: 4)) // ADC A, H
        case 0x8D: ADC(&A, register(L, cycles: 4)) // ADC A, L
        case 0x8E: ADC(&A, address: register16(HL, cycles: 8)) // ADC A, (HL)
        case 0x8F: ADC(&A, register(A, cycles: 4)) // ADC A, A
        case 0x90: SUB(&A, register(B, cycles: 4)) // SUB A, B
        case 0x91: SUB(&A, register(C, cycles: 4)) // SUB A, C
        case 0x92: SUB(&A, register(D, cycles: 4)) // SUB A, D
        case 0x93: SUB(&A, register(E, cycles: 4)) // SUB A, E
        case 0x94: SUB(&A, register(H, cycles: 4)) // SUB A, H
        case 0x95: SUB(&A, register(L, cycles: 4)) // SUB A, L
        case 0x96: SUB(&A, address: register16(HL, cycles: 8)) // SUB A, (HL)
        case 0x97: SUB(&A, register(A, cycles: 4)) // SUB A, A
        case 0x98: SBC(&A, register(B, cycles: 4)) // SBC A, B
        case 0x99: SBC(&A, register(C, cycles: 4)) // SBC A, C
        case 0x9A: SBC(&A, register(D, cycles: 4)) // SBC A, D
        case 0x9B: SBC(&A, register(E, cycles: 4)) // SBC A, E
        case 0x9C: SBC(&A, register(H, cycles: 4)) // SBC A, H
        case 0x9D: SBC(&A, register(L, cycles: 4)) // SBC A, L
        case 0x9E: SBC(&A, address: register16(HL, cycles: 8))  // SBC A, (HL)
        case 0x9F: SBC(&A, register(A, cycles: 4)) // SBC A, A
        case 0xA0: AND(&A, register(B, cycles: 4)) // AND A, B
        case 0xA1: AND(&A, register(C, cycles: 4)) // AND A, C
        case 0xA2: AND(&A, register(D, cycles: 4)) // AND A, D
        case 0xA3: AND(&A, register(E, cycles: 4)) // AND A, E
        case 0xA4: AND(&A, register(H, cycles: 4)) // AND A, H
        case 0xA5: AND(&A, register(L, cycles: 4)) // AND A, L
        case 0xA6: AND(&A, address: register16(HL, cycles: 8)) // AND A, (HL)
        case 0xA7: AND(&A, register(A, cycles: 4)) // AND A, A
        case 0xA8: XOR(&A, register(B, cycles: 4)) // XOR A, B
        case 0xA9: XOR(&A, register(C, cycles: 4)) // XOR A, C
        case 0xAA: XOR(&A, register(D, cycles: 4)) // XOR A, D
        case 0xAB: XOR(&A, register(E, cycles: 4)) // XOR A, E
        case 0xAC: XOR(&A, register(H, cycles: 4)) // XOR A, H
        case 0xAD: XOR(&A, register(L, cycles: 4)) // XOR A, L
        case 0xAE: XOR(&A, address: register16(HL, cycles: 8)) // XOR A, (HL)
        case 0xAF: XOR(&A, register(A, cycles: 4)) // XOR A, A
        case 0xB0: OR(&A, register(B, cycles: 4)) // OR A, B
        case 0xB1: OR(&A, register(C, cycles: 4)) // OR A, C
        case 0xB2: OR(&A, register(D, cycles: 4)) // OR A, D
        case 0xB3: OR(&A, register(E, cycles: 4)) // OR A, E
        case 0xB4: OR(&A, register(H, cycles: 4)) // OR A, H
        case 0xB5: OR(&A, register(L, cycles: 4)) // OR A, L
        case 0xB6: OR(&A, address: register16(HL, cycles: 8)) // OR A, (HL)
        case 0xB7: OR(&A, register(A, cycles: 4)) // OR A, A
        case 0xB8: CP(&A, register(B, cycles: 4)) // CP A, B
        case 0xB9: CP(&A, register(C, cycles: 4)) // CP A, C
        case 0xBA: CP(&A, register(D, cycles: 4)) // CP A, D
        case 0xBB: CP(&A, register(E, cycles: 4)) // CP A, E
        case 0xBC: CP(&A, register(H, cycles: 4)) // CP A, H
        case 0xBD: CP(&A, register(L, cycles: 4)) // CP A, L
        case 0xBE: CP(&A, address: register16(HL, cycles: 8)) // CP A, (HL)
        case 0xBF: CP(&A, register(A, cycles: 4)) // CP A, A
        case 0xC0: break
        case 0xC1: POP(&BC); implied(cycles: 12) // POP BC
        case 0xC2: break
        case 0xC3: break
        case 0xC4: break
        case 0xC5: PUSH(register16(BC, cycles: 16)) // PUSH BC
        case 0xC6: ADD(&A, immediate(cycles: 8)) // ADD A, d8
        case 0xC7: break
        case 0xC8: break
        case 0xC9: break
        case 0xCA: break
        case 0xCB: break
        case 0xCC: break
        case 0xCD: break
        case 0xCE: ADC(&A, immediate(cycles: 8)) // ADC A, d8
        case 0xCF: break
        case 0xD0: break
        case 0xD1: POP(&DE); implied(cycles: 12) // POP DE
        case 0xD2: break
        case 0xD4: break
        case 0xD5: PUSH(register16(DE, cycles: 16)) // PUSH DE
        case 0xD6: SUB(&A, immediate(cycles: 8))
        case 0xD7: break
        case 0xD8: break
        case 0xD9: break
        case 0xDA: break
        case 0xDC: break
        case 0xDE: SBC(&A, immediate(cycles: 8)) // SBC A, d8
        case 0xDF: break
        case 0xE0: LDH(offset: immediate(cycles: 12), A) // LD ($FF00+a8), A
        case 0xE1: POP(&HL); implied(cycles: 12) // POP HL
        case 0xE2: LDH(offset: C, register(A, cycles: 8)) // LD ($FF00+C), A
        case 0xE5: PUSH(register16(HL, cycles: 16)) // PUSH HL
        case 0xE6: AND(&A, immediate(cycles: 8)) // AND A, d8
        case 0xE7: break
        case 0xE8: break
        case 0xE9: break
        case 0xEA: LD(address: immediate16(cycles: 16), A) // LD (a16), A
        case 0xEE: XOR(&A, immediate(cycles: 8)) // XOR A, d8
        case 0xEF: break
        case 0xF0: LDH(&A, offset: immediate(cycles: 12)) // LD A, ($FF00+a8)
        case 0xF1: POP(&AF); implied(cycles: 12) // POP AF
        case 0xF2: LDH(&A, offset: register(C, cycles: 8)) // LD A, ($FF00+C)
        case 0xF3: break
        case 0xF5: PUSH(register16(AF, cycles: 16)) // PUSH AF
        case 0xF6: OR(&A, immediate(cycles: 8)) // OR A, d8
        case 0xF7: break
        case 0xF8: LDHL(offset: immediateSigned(cycles: 12)) // LD HL, SP+d8
        case 0xF9: LD(&SP, register16(HL, cycles: 8)) // LD SP, HL
        case 0xFA: LD(&A, address: immediate16(cycles: 16)) // LD A, (a16)
        case 0xFB: break
        case 0xFE: CP(&A, immediate(cycles: 8)) // CP A, d8
        case 0xFF: break
        default: fatalError("Invalid opcode")
        }
    }
}
