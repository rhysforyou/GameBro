import XCTest
@testable import GameBro

extension Int {
    func times(closure: () -> ()) {
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
        
        XCTAssert(cpu.A == UInt8(10), "Accumulator should have value of 10")
        XCTAssert(cpu.B == UInt8(20), "B register should have value of 20")
        
        cpu.LD(address: Address(0xDFFF), cpu.A)  // LD $DFFF, A
        cpu.LD(&cpu.C, address: Address(0xDFFF)) // LD C, $DFFF
        
        XCTAssert(cpu.C == UInt8(10), "C register should have value of 10")
    }
    
    func testEcho() {
        var cpu = CPU(memory: Memory())
        
        cpu.LD(address: Address(0xC000), 0xFF)
        cpu.LD(&cpu.A, address: Address(0xE000))
        
        XCTAssert(cpu.A == UInt8(0xFF), "Echo should contain same data as main RAM")
    }
    
    func testStep() {
        var cpu = CPU(memory: Memory())
        let program: [UInt8] = [
            0x06, 0x10, // LD B, 10 (8 cycles)
            0x78,       // LD A, B  (4 cycles)
            0x06, 0x20  // LD B, 20 (8 cycles)
        ]
        
        // Load program into RAM
        for (offset, byte) in program.enumerate() {
            cpu.memory.write(0xC000 + Address(offset), byte)
        }
        
        // Start program execution from RAM
        cpu.PC = 0xC000
        
        cpu.step()
        XCTAssert(cpu.B == UInt8(0x10))
        cpu.step()
        XCTAssert(cpu.A == UInt8(0x10))
        cpu.step()
        XCTAssert(cpu.B == UInt8(0x20))
        
        XCTAssert(cpu.cycle == 20)
    }
    
    func test8BitLoads() {
        var cpu = CPU(memory: Memory())
        let program: [UInt8] = [
            // LD r, d8
            0x06, 0x01, // LD B $01
            0x0E, 0x02, // LD C $02
            0x16, 0x03, // LD D $03
            0x1E, 0x04, // LD E $04
            0x26, 0x05, // LD H $05
            0x2E, 0x06, // LD L $06
            
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
            0x06, 0x01, // LD B $01
            
            0x48,       // LD C, B
            0x49,       // LD C, C
            0x4A,       // LD C, D
            0x4B,       // LD C, E
            0x4C,       // LD C, H
            0x4D,       // LD C, L
            0x0E, 0x02, // LD C $02
            
            0x50,       // LD D, B
            0x51,       // LD D, C
            0x52,       // LD D, D
            0x53,       // LD D, E
            0x54,       // LD D, H
            0x55,       // LD D, L
            0x16, 0x03, // LD D $03
            
            0x58,       // LD E, B
            0x59,       // LD E, C
            0x5A,       // LD E, D
            0x5B,       // LD E, E
            0x5C,       // LD E, H
            0x5D,       // LD E, L
            0x1E, 0x04, // LD E $04
            
            0x60,       // LD H, B
            0x61,       // LD H, C
            0x62,       // LD H, D
            0x63,       // LD H, E
            0x64,       // LD H, H
            0x65,       // LD H, L
            0x26, 0x05, // LD H $05
            
            0x68,       // LD L, B
            0x69,       // LD L, C
            0x6A,       // LD L, D
            0x6B,       // LD L, E
            0x6C,       // LD L, H
            0x6D,       // LD L, L
            0x2E, 0x06, // LD L $06
        ]
        
        // Load program into RAM
        for (offset, byte) in program.enumerate() {
            cpu.memory.write(0xC000 + Address(offset), byte)
        }
        
        // Start program execution from RAM
        cpu.PC = 0xC000
        
        cpu.step()
        XCTAssert(cpu.B == UInt8(0x01))
        cpu.step()
        XCTAssert(cpu.C == UInt8(0x02))
        cpu.step()
        XCTAssert(cpu.D == UInt8(0x03))
        cpu.step()
        XCTAssert(cpu.E == UInt8(0x04))
        cpu.step()
        XCTAssert(cpu.H == UInt8(0x05))
        cpu.step()
        XCTAssert(cpu.L == UInt8(0x06))
        
        cpu.step()
        XCTAssert(cpu.A == UInt8(0x00))
        cpu.step()
        XCTAssert(cpu.A == UInt8(0x01))
        cpu.step()
        XCTAssert(cpu.A == UInt8(0x02))
        cpu.step()
        XCTAssert(cpu.A == UInt8(0x03))
        cpu.step()
        XCTAssert(cpu.A == UInt8(0x04))
        cpu.step()
        XCTAssert(cpu.A == UInt8(0x05))
        cpu.step()
        XCTAssert(cpu.A == UInt8(0x06))
        
        cpu.step()
        XCTAssert(cpu.B == UInt8(0x01))
        cpu.step()
        XCTAssert(cpu.B == UInt8(0x02))
        cpu.step()
        XCTAssert(cpu.B == UInt8(0x03))
        cpu.step()
        XCTAssert(cpu.B == UInt8(0x04))
        cpu.step()
        XCTAssert(cpu.B == UInt8(0x05))
        cpu.step()
        XCTAssert(cpu.B == UInt8(0x06))
        cpu.step()
        
        cpu.step()
        XCTAssert(cpu.C == UInt8(0x01))
        cpu.step()
        XCTAssert(cpu.C == UInt8(0x01))
        cpu.step()
        XCTAssert(cpu.C == UInt8(0x03))
        cpu.step()
        XCTAssert(cpu.C == UInt8(0x04))
        cpu.step()
        XCTAssert(cpu.C == UInt8(0x05))
        cpu.step()
        XCTAssert(cpu.C == UInt8(0x06))
        cpu.step()
        
        cpu.step()
        XCTAssert(cpu.D == UInt8(0x01))
        cpu.step()
        XCTAssert(cpu.D == UInt8(0x02))
        cpu.step()
        XCTAssert(cpu.D == UInt8(0x02))
        cpu.step()
        XCTAssert(cpu.D == UInt8(0x04))
        cpu.step()
        XCTAssert(cpu.D == UInt8(0x05))
        cpu.step()
        XCTAssert(cpu.D == UInt8(0x06))
        cpu.step()
        
        cpu.step()
        XCTAssert(cpu.E == UInt8(0x01))
        cpu.step()
        XCTAssert(cpu.E == UInt8(0x02))
        cpu.step()
        XCTAssert(cpu.E == UInt8(0x03))
        cpu.step()
        XCTAssert(cpu.E == UInt8(0x03))
        cpu.step()
        XCTAssert(cpu.E == UInt8(0x05))
        cpu.step()
        XCTAssert(cpu.E == UInt8(0x06))
        cpu.step()
        
        cpu.step()
        XCTAssert(cpu.H == UInt8(0x01))
        cpu.step()
        XCTAssert(cpu.H == UInt8(0x02))
        cpu.step()
        XCTAssert(cpu.H == UInt8(0x03))
        cpu.step()
        XCTAssert(cpu.H == UInt8(0x04))
        cpu.step()
        XCTAssert(cpu.H == UInt8(0x04))
        cpu.step()
        XCTAssert(cpu.H == UInt8(0x06))
        cpu.step()
        
        cpu.step()
        XCTAssert(cpu.L == UInt8(0x01))
        cpu.step()
        XCTAssert(cpu.L == UInt8(0x02))
        cpu.step()
        XCTAssert(cpu.L == UInt8(0x03))
        cpu.step()
        XCTAssert(cpu.L == UInt8(0x04))
        cpu.step()
        XCTAssert(cpu.L == UInt8(0x05))
        cpu.step()
        XCTAssert(cpu.L == UInt8(0x05))
        cpu.step()
    }
    
}
