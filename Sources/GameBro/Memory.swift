public typealias Address = UInt16

extension Address {

    /// Construct a byte from a page and offset
    ///
    /// - parameter page:   an 8-bit page number
    /// - parameter offset: an 8-bit offset
    ///
    /// - returns: a 16-bit address with the provided page and offset
    init(page: UInt8, offset: UInt8) {
        self = UInt16(page) << 8 | UInt16(offset)
    }

    /// The page (first 8 bits) of the address
    var page: UInt8 {
        return UInt8(self >> 8)
    }

    /// The offset (last 8 bits) of the address
    var offset: UInt8 {
        return UInt8(self & 0xFF)
    }
}

/// An implementation of the Game Boy's mapped memory
///
/// ## Memory Layout
///
///     +-----------------+------------------------------+
///     | 0x0000..<0x4000 | 16k cart ROM bank #0         |
///     | 0x4000..<0x8000 | 16k switchable cart ROM bank |
///     | 0x8000..<0xA000 | 8k VRAM                      |
///     | 0xA000..<0xC000 | 8k switchable RAM bank       |
///     | 0xC000..<0xE000 | 8k internal RAM              |
///     | 0xE000..<0xFE00 | Echo of 8k internal RAM      |
///     | 0xFE00..<0xFEA0 | Sprite attrib memory (OAM)   |
///     | 0xFF00..<0xFF4C | I/O Ports                    |
///     | 0xFF80..<0xFFFF | Zero-page RAM                |
///     | 0xFFFF          | Interrupt enable register    |
///     +-----------------+------------------------------+
public struct Memory {
    /// 8kb of main RAM
    private var RAM = Array<UInt8>(repeating: 0x00, count: 0x2000)

    /// Read the byte at `address`
    ///
    /// - parameter address: the address of the byte to be read
    ///
    /// - returns: the byte at `address`
    public func read(_ address: Address) -> UInt8 {
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
            return RAM[Int(address % 0x2000)]
        case 0xFE00..<0xFEA0: // Sprite attrib memory (OAM)
            break
        case 0xFF00..<0xFF4C: // I/O Ports
            break
        case 0xFF80..<0xFFFF: // Zero-page RAM
            return RAM[Int(address % 0x2000)]
        case 0xFFFF:          // Interrupt enable register
            break
        default:
            fatalError("Not yet implemented")
        }

        return 0x00
    }

    /// Read two bytes at `address`
    ///
    /// - parameter address: the address of the bytes to be read
    ///
    /// - returns: the two bytes at `address`
    public func read16(_ address: Address) -> UInt16 {
        let low  = read(address)
        let high = read(address + 1)

        return UInt16(high) << 8 | UInt16(low)
    }

    /// Write a byte to `address`
    ///
    /// - parameter address: the address to be written to
    /// - parameter value:   the value to be written
    public mutating func write(_ address: Address, _ value: UInt8) {
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
            RAM[Int(address % 0x2000)] = value
        case 0xE000..<0xFE00: // Echo of 8k internal RAM
            RAM[Int(address % 0x2000)] = value
        case 0xFE00..<0xFEA0: // Sprite attrib memory (OAM)
            break
        case 0xFF00..<0xFF4C: // I/O Ports
            break
        case 0xFF80..<0xFFFF: // Zero-page RAM
            RAM[Int(address % 0x2000)] = value
        case 0xFFFF:          // Interrupt enable register
            break
        default:
            fatalError("Not yet implemented")
        }
    }

    /// Write a 16-bit value to `address`
    ///
    /// - parameter address: the address to be written to
    /// - parameter value:   the 16-bit value to be written
    public mutating func write16(_ address: Address, _ value: UInt16) {
        let low  = UInt8(value & 0x00FF)
        let high = UInt8(value >> 8)

        write(address, low)
        write(address + 1, high)
    }
}
