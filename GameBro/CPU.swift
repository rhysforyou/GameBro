import Foundation

/// An implementation of the Sharp LR35902 processor used by the Game Boy
///
/// ## Register Layout
///
///      FEDCBA98 76543210
///     +--------+--------+
///     |   A    |   F    |  AF
///     |   B    |   C    |  BC
///     |   D    |   E    |  DE
///     |   H    |   L    |  HL
///     +--------+--------+
///     |       SP        |  Stack Pointer
///     |       PC        |  Program Counter
///     +-----------------+
///
/// ## Flags
///
///       76543210
///     +----------+
///     | ZNHC---- |
///     +----------+
///
/// + Z - Zero - Set when the result of a math operation is zero, or two values match for a CP operation
/// + N - Subtract - Set if a subtraction was performed in the last math operation
/// + H - Half-Carry - Set if a carry occurred from the lower nibble in the last math operation
/// + C - Carry - Set if a carry occurred in the last math operation, or if the accumulator A is less than value for a CP operation

public struct CPU {
    
    /// The stack pointer
    public var SP: UInt16 = 0
    
    /// The program counter
    public var PC: UInt16 = 0x100
    
    /// The A register
    public var A: UInt8 = 0
    
    /// The flag register
    public var F: UInt8 = 0
    
    /// The B register
    public var B: UInt8 = 0
    
    /// The C register
    public var C: UInt8 = 0
    
    /// The D register
    public var D: UInt8 = 0
    
    /// The E register
    public var E: UInt8 = 0
    
    /// The H register
    public var H: UInt8 = 0
    
    /// The L register
    public var L: UInt8 = 0
    
    public var memory: Memory
    
    public init(memory: Memory) {
        self.memory = memory
    }
    
}

// Pseudo registers
public extension CPU {
    public var AF: UInt16 {
        get {
            return UInt16(A) << 8 | UInt16(F)
        }
        set {
            A = UInt8(newValue << 8)
            F = UInt8(newValue & 0x00FF)
        }
    }
    
    public var BC: UInt16 {
        get {
            return UInt16(B) << 8 | UInt16(C)
        }
        set {
            B = UInt8(newValue << 8)
            C = UInt8(newValue & 0x00FF)
        }
    }
    
    public var DE: UInt16 {
        get {
            return UInt16(D) << 8 | UInt16(E)
        }
        set {
            D = UInt8(newValue << 8)
            E = UInt8(newValue & 0x00FF)
        }
    }
    
    public var HL: UInt16 {
        get {
            return UInt16(H) << 8 | UInt16(L)
        }
        set {
            H = UInt8(newValue << 8)
            L = UInt8(newValue & 0x00FF)
        }
    }
}

// Flags
public extension CPU {
    
    internal func getFlag(flag: UInt8) -> Bool {
        return (flag & F) != 0
    }
    
    internal mutating func setFlag(flag: UInt8, _ value: Bool) {
        if value {
            F |= flag
        } else {
            F &= ~flag
        }
    }
    
    
    /// Zero flag
    public var ZFlag: Bool {
        get {
            return getFlag(0x80)
        }
        set {
            setFlag(0x80, newValue)
        }
    }
    
    /// Subtract flag
    public var NFlag: Bool {
        get {
            return getFlag(0x40)
        }
        set {
            setFlag(0x40, newValue)
        }
    }
    
    /// Half-carry flag
    public var HFlag: Bool {
        get {
            return getFlag(0x20)
        }
        set {
            setFlag(0x20, newValue)
        }
    }
    
    /// Carry flag
    public var CFlag: Bool {
        get {
            return getFlag(0x10)
        }
        set {
            setFlag(0x10, newValue)
        }
    }
}
