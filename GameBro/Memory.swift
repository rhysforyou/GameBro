import Foundation

public typealias Address = Int32

public struct Memory {
    // 8kb of main RAM
    private var RAM = Array<UInt8>(count: 0x2000, repeatedValue: 0x00)
    
    public func read(address: Address) -> UInt8 {
        switch address {
        case 0xC000..<0xE000: // Internal RAM
            return RAM[Int(address % 0x2000)]
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
