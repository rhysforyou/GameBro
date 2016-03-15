import Foundation

public typealias Address = UInt16

extension Address {
    init(_ page: UInt8, _ offset: UInt8) {
        self = UInt16(page) << 8 | UInt16(offset)
    }
    
    var page: UInt8 {
        return UInt8(self >> 8)
    }
    
    var offset: UInt8 {
        return UInt8(self & 0xFF)
    }
}

public struct Memory {
    // 8kb of main RAM
    private var RAM = Array<UInt8>(count: 0x2000, repeatedValue: 0x00)
    
    public func read(address: Address) -> UInt8 {
        switch address {
        case 0x0000..<0x4000: // 16k cart ROM bank #0
            break
        case 0x4000..<0x8000: // 16k switchable cart ROM bank
            break
        case 0x8000..<0xA000: // 8k VRAM
            break
        case 0xA000..<0xC000: // 8k switchable RAM bank
            break
        case 0xC000..<0xE000: // 8k internal RAM
            return RAM[Int(address % 0x2000)]
        case 0xE000..<0xFE00: // Echo of 8k internal RAM
            // Just offset the address page?
            break
        case 0xFE00..<0xFEA0: // Sprite attrib memory (OAM)
            break
        case 0xFF00..<0xFF4C: // I/O Ports
            break
        case 0xFF80..<0xFFFF: // Internal RAM
            break
        case 0xFFFF:          // Interrupt enable register
            break
        default:
            fatalError("Not yet implemented")
        }
    }
    
    public func read16(address: Address) -> UInt16 {
        let low  = read(address)
        let high = read(address + 1)
        
        return UInt16(high) << 8 | UInt16(low)
    }
    
    public mutating func write(address: Address, _ value: UInt8) {
        switch address {
        case 0xC000..<0xE000:
            RAM[Int(address % 0x2000)] = value
        default:
            fatalError("Not yet implemented")
        }
    }
    
    public mutating func write16(address: Address, _ value: UInt16) {
        let low  = UInt8(value & 0x00FF)
        let high = UInt8(value >> 8)
        
        write(address, low)
        write(address + 1, high)
    }
}
