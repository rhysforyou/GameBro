import XCTest
@testable import GameBro

extension Int {
    func times(_ closure: () -> ()) {
        for _ in 0..<self {
            closure()
        }
    }
}

class CPUTests : XCTestCase {

    func testLD() {
        var cpu = CPU(memory: Memory())

        cpu.LD(&cpu.A, UInt8(20)) // LD A, 20
        cpu.LD(&cpu.B, cpu.A)     // LD B, A
        cpu.LD(&cpu.A, UInt8(10)) // LD A, 10

        XCTAssertEqual(cpu.A, UInt8(10), "Accumulator should have value of 10")
        XCTAssertEqual(cpu.B, UInt8(20), "B register should have value of 20")

        cpu.LD(address: Address(0xDFFF), cpu.A)  // LD $DFFF, A
        cpu.LD(&cpu.C, address: Address(0xDFFF)) // LD C, $DFFF

        XCTAssertEqual(cpu.C, UInt8(10), "C register should have value of 10")
    }

    func testEcho() {
        var cpu = CPU(memory: Memory())

        cpu.LD(address: Address(0xC000), UInt8(0xFF))
        cpu.LD(&cpu.A, address: Address(0xE000))

        XCTAssertEqual(cpu.A, UInt8(0xFF), "Echo should contain same data as main RAM")
    }

    func testStep() {
        var cpu = CPU(memory: Memory())
        let program: [UInt8] = [
            0x06, 0x10, // LD B, 10 (8 cycles)
            0x78,       // LD A, B  (4 cycles)
            0x06, 0x20  // LD B, 20 (8 cycles)
        ]

        // Load program into RAM
        for (offset, byte) in program.enumerated() {
            cpu.memory.write(0xC000 + Address(offset), byte)
        }

        // Start program execution from RAM
        cpu.PC = 0xC000

        cpu.step()
        XCTAssertEqual(cpu.B, UInt8(0x10))
        cpu.step()
        XCTAssertEqual(cpu.A, UInt8(0x10))
        cpu.step()
        XCTAssertEqual(cpu.B, UInt8(0x20))

        XCTAssertEqual(cpu.cycle, 20)
    }

    func test8BitLoads() {
        var cpu = CPU(memory: Memory())
        let program: [UInt8] = [
            // LD r, d8
            0x3E, 0xA0, // LD A, $A0
            0x06, 0x01, // LD B, $01
            0x0E, 0x02, // LD C, $02
            0x16, 0x03, // LD D, $03
            0x1E, 0x04, // LD E, $04
            0x26, 0x05, // LD H, $05
            0x2E, 0x06, // LD L, $06

            // LD r1, r2
            0x7F,       // LD A, A
            0x78,       // LD A, B
            0x79,       // LD A, C
            0x7A,       // LD A, D
            0x7B,       // LD A, E
            0x7C,       // LD A, H
            0x7D,       // LD A, L

            0x40,       // LD B, B
            0x41,       // LD B, C
            0x42,       // LD B, D
            0x43,       // LD B, E
            0x44,       // LD B, H
            0x45,       // LD B, L
            0x06, 0x01, // LD B, $01

            0x48,       // LD C, B
            0x49,       // LD C, C
            0x4A,       // LD C, D
            0x4B,       // LD C, E
            0x4C,       // LD C, H
            0x4D,       // LD C, L
            0x0E, 0x02, // LD C, $02

            0x50,       // LD D, B
            0x51,       // LD D, C
            0x52,       // LD D, D
            0x53,       // LD D, E
            0x54,       // LD D, H
            0x55,       // LD D, L
            0x16, 0x03, // LD D, $03

            0x58,       // LD E, B
            0x59,       // LD E, C
            0x5A,       // LD E, D
            0x5B,       // LD E, E
            0x5C,       // LD E, H
            0x5D,       // LD E, L
            0x1E, 0x04, // LD E, $04

            0x60,       // LD H, B
            0x61,       // LD H, C
            0x62,       // LD H, D
            0x63,       // LD H, E
            0x64,       // LD H, H
            0x65,       // LD H, L
            0x26, 0x05, // LD H, $05

            0x68,       // LD L, B
            0x69,       // LD L, C
            0x6A,       // LD L, D
            0x6B,       // LD L, E
            0x6C,       // LD L, H
            0x6D,       // LD L, L
            0x2E, 0x06, // LD L, $06

            // LD r, (HL)
            0x26, 0xD0, // LD H, $D0
            0x2E, 0x00, // LD L, $00
            0x36, 0xF0, // LD (HL), $F0
            0x46,       // LD B, (HL)
            0x4E,       // LD C, (HL)
            0x56,       // LD D, (HL)
            0x5E,       // LD E, (HL)
            0x66,       // LD H, (HL)
            0x26, 0xD0, // LD H, $D0
            0x6E,       // LD L, (HL)
            0x2E, 0x00, // LD L ,$00

            // LD (HL), r
            0x06, 0x01, // LD B, $01
            0x0E, 0x02, // LD C, $02
            0x16, 0x03, // LD D, $03
            0x1E, 0x04, // LD E, $04
            0x70,       // LD (HL), B
            0x7E,       // LD A, (HL)
            0x71,       // LD (HL), C
            0x7E,       // LD A, (HL)
            0x72,       // LD (HL), D
            0x7E,       // LD A, (HL)
            0x73,       // LD (HL), E
            0x7E,       // LD A, (HL)
            0x74,       // LD (HL), H
            0x7E,       // LD A, (HL)
            0x75,       // LD (HL), L
            0x7E,       // LD A, (HL)

            // LD r, A
            0x7F,       // LD A, A
            0x47,       // LD B, A
            0x4F,       // LD C, A
            0x57,       // LD D, A
            0x5F,       // LD E, A
            0x67,       // LD H, A
            0x6F,       // LD L, A

            0x26, 0xD0, // LD H, $D0
            0x2E, 0x01, // LD L, $01
            0x36, 0xF1, // LD (HL), $F1
            0x2E, 0x02, // LD L, $02
            0x36, 0xF2, // LD (HL), $F2
            0x06, 0xD0, // LD B, $D0
            0x0E, 0x01, // LD C, $01
            0x16, 0xD0, // LD D, $D0
            0x1E, 0x02, // LD E, $02
            0x0A,       // LD A, (BC)
            0x1A,       // LD A, (DE)

            0xFA, 0x01, 0xD0, // LD A, ($D001)

            0x26, 0xDF, // LD H, $DF
            0x2E, 0xA0, // LD L, $A0
            0x36, 0xF0, // LD (HL), $F0
            0x2E, 0xA1, // LD L, $A1
            0x36, 0xF1, // LD (HL), $F1
            0xF0, 0xA0, // LD A, ($F0)
            0x0E, 0xA1, // LD C, $A1
            0xF2,       // LD A, (C)

            0x3E, 0xAA, // LD A, $AA
            0xEA, 0xA0, 0xDF, // LD ($DFA0), A
            0x3E, 0xBB, // LD A, $BB
            0xE0, 0xA1, // LD ($A1), A
            0x3E, 0xCC, // LD A, $CC
            0x0E, 0xA2, // LD C, $A2
            0xE2,       // LD (C), A
            0xF0, 0xA0, // LD A, ($A0)
            0xF0, 0xA1, // LD A, ($A1)
            0xF0, 0xA2, // LD A, ($A2)
        ]

        // Load program into RAM
        for (offset, byte) in program.enumerated() {
            cpu.memory.write(0xC000 + Address(offset), byte)
        }

        // Start program execution from RAM
        cpu.PC = 0xC000

        cpu.step()
        XCTAssertEqual(cpu.A, UInt8(0xA0))
        cpu.step()
        XCTAssertEqual(cpu.B, UInt8(0x01))
        cpu.step()
        XCTAssertEqual(cpu.C, UInt8(0x02))
        cpu.step()
        XCTAssertEqual(cpu.D, UInt8(0x03))
        cpu.step()
        XCTAssertEqual(cpu.E, UInt8(0x04))
        cpu.step()
        XCTAssertEqual(cpu.H, UInt8(0x05))
        cpu.step()
        XCTAssertEqual(cpu.L, UInt8(0x06))

        cpu.step()
        XCTAssertEqual(cpu.A, UInt8(0xA0))
        cpu.step()
        XCTAssertEqual(cpu.A, UInt8(0x01))
        cpu.step()
        XCTAssertEqual(cpu.A, UInt8(0x02))
        cpu.step()
        XCTAssertEqual(cpu.A, UInt8(0x03))
        cpu.step()
        XCTAssertEqual(cpu.A, UInt8(0x04))
        cpu.step()
        XCTAssertEqual(cpu.A, UInt8(0x05))
        cpu.step()
        XCTAssertEqual(cpu.A, UInt8(0x06))

        cpu.step()
        XCTAssertEqual(cpu.B, UInt8(0x01))
        cpu.step()
        XCTAssertEqual(cpu.B, UInt8(0x02))
        cpu.step()
        XCTAssertEqual(cpu.B, UInt8(0x03))
        cpu.step()
        XCTAssertEqual(cpu.B, UInt8(0x04))
        cpu.step()
        XCTAssertEqual(cpu.B, UInt8(0x05))
        cpu.step()
        XCTAssertEqual(cpu.B, UInt8(0x06))
        cpu.step()

        cpu.step()
        XCTAssertEqual(cpu.C, UInt8(0x01))
        cpu.step()
        XCTAssertEqual(cpu.C, UInt8(0x01))
        cpu.step()
        XCTAssertEqual(cpu.C, UInt8(0x03))
        cpu.step()
        XCTAssertEqual(cpu.C, UInt8(0x04))
        cpu.step()
        XCTAssertEqual(cpu.C, UInt8(0x05))
        cpu.step()
        XCTAssertEqual(cpu.C, UInt8(0x06))
        cpu.step()

        cpu.step()
        XCTAssertEqual(cpu.D, UInt8(0x01))
        cpu.step()
        XCTAssertEqual(cpu.D, UInt8(0x02))
        cpu.step()
        XCTAssertEqual(cpu.D, UInt8(0x02))
        cpu.step()
        XCTAssertEqual(cpu.D, UInt8(0x04))
        cpu.step()
        XCTAssertEqual(cpu.D, UInt8(0x05))
        cpu.step()
        XCTAssertEqual(cpu.D, UInt8(0x06))
        cpu.step()

        cpu.step()
        XCTAssertEqual(cpu.E, UInt8(0x01))
        cpu.step()
        XCTAssertEqual(cpu.E, UInt8(0x02))
        cpu.step()
        XCTAssertEqual(cpu.E, UInt8(0x03))
        cpu.step()
        XCTAssertEqual(cpu.E, UInt8(0x03))
        cpu.step()
        XCTAssertEqual(cpu.E, UInt8(0x05))
        cpu.step()
        XCTAssertEqual(cpu.E, UInt8(0x06))
        cpu.step()

        cpu.step()
        XCTAssertEqual(cpu.H, UInt8(0x01))
        cpu.step()
        XCTAssertEqual(cpu.H, UInt8(0x02))
        cpu.step()
        XCTAssertEqual(cpu.H, UInt8(0x03))
        cpu.step()
        XCTAssertEqual(cpu.H, UInt8(0x04))
        cpu.step()
        XCTAssertEqual(cpu.H, UInt8(0x04))
        cpu.step()
        XCTAssertEqual(cpu.H, UInt8(0x06))
        cpu.step()

        cpu.step()
        XCTAssertEqual(cpu.L, UInt8(0x01))
        cpu.step()
        XCTAssertEqual(cpu.L, UInt8(0x02))
        cpu.step()
        XCTAssertEqual(cpu.L, UInt8(0x03))
        cpu.step()
        XCTAssertEqual(cpu.L, UInt8(0x04))
        cpu.step()
        XCTAssertEqual(cpu.L, UInt8(0x05))
        cpu.step()
        XCTAssertEqual(cpu.L, UInt8(0x05))
        cpu.step()

        4.times { cpu.step() }
        XCTAssertEqual(cpu.B, UInt8(0xF0))
        cpu.step()
        XCTAssertEqual(cpu.C, UInt8(0xF0))
        cpu.step()
        XCTAssertEqual(cpu.D, UInt8(0xF0))
        cpu.step()
        XCTAssertEqual(cpu.E, UInt8(0xF0))
        cpu.step()
        XCTAssertEqual(cpu.H, UInt8(0xF0))
        2.times { cpu.step() }
        XCTAssertEqual(cpu.L, UInt8(0xF0))
        cpu.step()

        6.times { cpu.step() }
        XCTAssertEqual(cpu.A, cpu.B)
        2.times{ cpu.step() }
        XCTAssertEqual(cpu.A, cpu.C)
        2.times{ cpu.step() }
        XCTAssertEqual(cpu.A, cpu.D)
        2.times{ cpu.step() }
        XCTAssertEqual(cpu.A, cpu.E)
        2.times{ cpu.step() }
        XCTAssertEqual(cpu.A, cpu.H)
        2.times{ cpu.step() }
        XCTAssertEqual(cpu.A, cpu.L)

        cpu.step()
        XCTAssertEqual(cpu.A, cpu.A)
        cpu.step()
        XCTAssertEqual(cpu.B, cpu.A)
        cpu.step()
        XCTAssertEqual(cpu.C, cpu.A)
        cpu.step()
        XCTAssertEqual(cpu.D, cpu.A)
        cpu.step()
        XCTAssertEqual(cpu.E, cpu.A)
        cpu.step()
        XCTAssertEqual(cpu.H, cpu.A)
        cpu.step()
        XCTAssertEqual(cpu.L, cpu.A)

        10.times { cpu.step() }
        XCTAssertEqual(cpu.A, UInt8(0xF1))
        cpu.step()
        XCTAssertEqual(cpu.A, UInt8(0xF2))
        cpu.step()
        XCTAssertEqual(cpu.A, UInt8(0xF1))
        6.times { cpu.step() }
        XCTAssertEqual(cpu.A, UInt8(0xF0))
        2.times { cpu.step() }
        XCTAssertEqual(cpu.A, UInt8(0xF1))

        8.times { cpu.step() }
        XCTAssertEqual(cpu.A, UInt8(0xAA))
        cpu.step()
        XCTAssertEqual(cpu.A, UInt8(0xBB))
        cpu.step()
        XCTAssertEqual(cpu.A, UInt8(0xCC))
    }

    func test16BitLoads() {
        var cpu = CPU(memory: Memory())
        let program: [UInt8] = [
            // LD r, d16
            0x01, 0x23, 0x01, // LD BC, $0123
            0x11, 0x67, 0x45, // LD DE, $4567
            0x21, 0xAB, 0x89, // LD HL, $89AB
            0x31, 0xEF, 0xCD, // LD SP, $CDEF

            0x21, 0xEF, 0xFF, // LD HL, $FFEF
            0xF9,             // LD SP, HL

            0xF8, 0xF0,       // LD HL, SP+$F0 (-16)
            0xF8, 0x10,       // LD HL, SP+$F0 (+16)

            0x21, 0xAB, 0x89, // LD HL, $89AB
            0xF5,             // PUSH AF
            0xC5,             // PUSH BC
            0xD5,             // PUSH DE
            0xE5,             // PUSH HL
            0x21, 0xEF, 0xCD, // LD HL, $CDEF
            0xE5,             // PUSH HL
            0xF1,             // POP AF
            0xC1,             // POP BC
            0xD1,             // POP DE
            0xE1,             // POP HL

            0x08, 0x00, 0xD0, // LD ($D000), SP
            0x21, 0x00, 0xD0, // LD HL, $D000
            0x2A,             // LD A, (HL+)
            0x2A,             // LD A, (HL+)
        ]


        // Load program into RAM
        for (offset, byte) in program.enumerated() {
            cpu.memory.write(0xC000 + Address(offset), byte)
        }

        // Start program execution from RAM
        cpu.PC = 0xC000

        cpu.step()
        XCTAssertEqual(cpu.BC, 0x0123)
        XCTAssertEqual(cpu.B, 0x01)
        XCTAssertEqual(cpu.C, 0x23)

        cpu.step()
        XCTAssertEqual(cpu.DE, 0x4567)
        XCTAssertEqual(cpu.D, 0x45)
        XCTAssertEqual(cpu.E, 0x67)

        cpu.step()
        XCTAssertEqual(cpu.HL, 0x89AB)
        XCTAssertEqual(cpu.H, 0x89)
        XCTAssertEqual(cpu.L, 0xAB)

        cpu.step()
        XCTAssertEqual(cpu.SP, 0xCDEF)

        2.times { cpu.step() }
        XCTAssertEqual(cpu.SP, 0xFFEF)

        cpu.step()
        XCTAssertEqual(cpu.HL, 0xFFDF)
        XCTAssertEqual(cpu.CFlag, true)
        XCTAssertEqual(cpu.HFlag, true)
        cpu.step()
        XCTAssertEqual(cpu.HL, 0xFFFF)
        XCTAssertEqual(cpu.CFlag, false)
        XCTAssertEqual(cpu.HFlag, true)

        11.times { cpu.step() }
        XCTAssertEqual(cpu.AF, 0xCDEF)
        XCTAssertEqual(cpu.BC, 0x89AB)
        XCTAssertEqual(cpu.DE, 0x4567)
        XCTAssertEqual(cpu.HL, 0x0123)

        3.times { cpu.step() }
        XCTAssertEqual(cpu.A, cpu.SP.offset)
        cpu.step()
        XCTAssertEqual(cpu.A, cpu.SP.page)
    }

    func testADD() {
        var cpu = CPU(memory: Memory())
        let program: [UInt8] = [
            0x31, 0xFF, 0xFF, // LD SP, $FFFF

            0x3E, 0x10, // LD A $10
            0x06, 0x01, // LD B $01
            0x0E, 0x02, // LD C $02
            0x16, 0x03, // LD D $03
            0x1E, 0x04, // LD E $04
            0x26, 0x05, // LD H $05
            0x2E, 0x06, // LD L $06

            0x87,       // ADD A, A
            0x80,       // ADD A, B
            0x81,       // ADD A, C
            0x82,       // ADD A, D
            0x83,       // ADD A, E
            0x84,       // ADD A, H
            0x85,       // ADD A, L

            0x3E, 0x0F, // LD A, $0F
            0xC6, 0x01, // ADD A, $01  (half carry)
            0xC6, 0xF0, // ADD A, $F0  (full carry)

            // Push 0xFFF0 onto the stack, then add the lower nibble (0xF0) to A
            0x21, 0xF0, 0xFF, // LD HL $FFF0
            0xE5,             // PUSH HL
            0xF8, 0x00,       // LD HL, SP+$0
            0x3E, 0x00,       // LD A, $00
            0x86,             // ADD A, (HL)
        ]


        // Load program into RAM
        for (offset, byte) in program.enumerated() {
            cpu.memory.write(0xC000 + Address(offset), byte)
        }

        // Start program execution from RAM
        cpu.PC = 0xC000

        8.times { cpu.step() }
        XCTAssertEqual(cpu.A, 0x10)
        cpu.step()
        XCTAssertEqual(cpu.A, 0x20)
        cpu.step()
        XCTAssertEqual(cpu.A, 0x21)
        cpu.step()
        XCTAssertEqual(cpu.A, 0x23)
        cpu.step()
        XCTAssertEqual(cpu.A, 0x26)
        cpu.step()
        XCTAssertEqual(cpu.A, 0x2A)
        cpu.step()
        XCTAssertEqual(cpu.A, 0x2F)
        cpu.step()
        XCTAssertEqual(cpu.A, 0x35)

        2.times { cpu.step() }
        XCTAssertEqual(cpu.HFlag, true)
        XCTAssertEqual(cpu.CFlag, false)
        cpu.step()
        XCTAssertEqual(cpu.HFlag, false)
        XCTAssertEqual(cpu.CFlag, true)

        5.times { cpu.step() }
        XCTAssertEqual(cpu.A, 0xF0)
    }

    func testSUB() {
        var cpu = CPU(memory: Memory())
        let program: [UInt8] = [
            0x31, 0xFF, 0xFF, // LD SP, $FFFF

            0x3E, 0x10, // LD A $10
            0x06, 0x01, // LD B $01
            0x0E, 0x02, // LD C $02
            0x16, 0x03, // LD D $03
            0x1E, 0x04, // LD E $04
            0x26, 0x05, // LD H $05
            0x2E, 0x06, // LD L $06

            0x97,       // SUB A, A
            0x3E, 0x10, // LD A $10
            0x90,       // SUB A, B
            0x3E, 0x10, // LD A $10
            0x91,       // SUB A, C
            0x3E, 0x10, // LD A $10
            0x92,       // SUB A, D
            0x3E, 0x10, // LD A $10
            0x93,       // SUB A, E
            0x3E, 0x10, // LD A $10
            0x94,       // SUB A, H
            0x3E, 0x10, // LD A $10
            0x95,       // SUB A, L
        ]


        // Load program into RAM
        for (offset, byte) in program.enumerated() {
            cpu.memory.write(0xC000 + Address(offset), byte)
        }

        // Start program execution from RAM
        cpu.PC = 0xC000

        8.times { cpu.step() }
        XCTAssertEqual(cpu.A, 0x10)
        cpu.step()
        XCTAssertEqual(cpu.A, 0x00)
        2.times { cpu.step() }
        XCTAssertEqual(cpu.A, 0x0F)
        2.times { cpu.step() }
        XCTAssertEqual(cpu.A, 0x0E)
        2.times { cpu.step() }
        XCTAssertEqual(cpu.A, 0x0D)
        2.times { cpu.step() }
        XCTAssertEqual(cpu.A, 0x0C)
        2.times { cpu.step() }
        XCTAssertEqual(cpu.A, 0x0B)
        2.times { cpu.step() }
        XCTAssertEqual(cpu.A, 0x0A)
    }

    static var allTests = [
        ("testLD", testLD),
        ("testEcho", testEcho),
        ("testStep", testStep),
        ("test8BitLoads", test8BitLoads),
        ("test16BitLoads", test16BitLoads),
        ("testADD", testADD),
        ("testSUB", testSUB)
    ]

}
