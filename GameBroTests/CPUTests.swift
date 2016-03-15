import XCTest
@testable import GameBro

class CPUTests : XCTestCase {
    
    func testLD() {
        var cpu = CPU(memory: Memory())
        
        cpu.LD(&cpu.A, UInt8(20)) // LD A, 20
        cpu.LD(&cpu.B, cpu.A)     // LD B, A
        cpu.LD(&cpu.A, UInt8(10)) // LD A, 10
        
        XCTAssert(cpu.A == UInt8(10), "Accumulator should have value of 10")
        XCTAssert(cpu.B == UInt8(20), "B register should have value of 20")
        
        cpu.LD(Address(0xDFFF), cpu.A)  // LD $DFFF, A
        cpu.LD(&cpu.C, Address(0xDFFF)) // LD C, $DFFF
        
        XCTAssert(cpu.C == UInt8(10), "C register should have value of 10")
    }
    
    func testEcho() {
        var cpu = CPU(memory: Memory())
        
        cpu.LD(Address(0xC000), 0xFF)
        cpu.LD(&cpu.A, Address(0xE000))
        
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
    
}
