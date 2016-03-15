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
    
    func testStep() {
        var cpu = CPU(memory: Memory())
        var program: [UInt8] = [
            0x06, 0x10, // LD B, 10
            0x78,       // LD A, B
            0x06, 0x20  // LD B, 20
        ]
    }
    
}
