public extension CPU {

    /// `ADC r, d8` - Add value + carry flag to register
    ///
    /// - parameter register: the register to add to
    /// - parameter value:    the value to be added
    public mutating func ADC(_ register: inout UInt8, _ value: UInt8) {
        let carry: UInt8 = CFlag ? 1 : 0
        let high = UInt16(register) &+ UInt16(value) &+ UInt16(carry)
        let low  = (register & 0x0F) &+ (value & 0x0F) &+ carry

        ZFlag = high == 0
        NFlag = false
        HFlag = low > 0x0F
        CFlag = high > 0xFF

        register = register &+ value &+ carry
    }
    /// `ADC r, (a16)` - Add value at address + carry flag to register
    ///
    /// - parameter register: the register to add to
    /// - parameter address:  the address of the value to be added
    public mutating func ADC(_ register: inout UInt8, address: Address) {
        ADC(&register, memory.read(address))
    }

    /// `ADD r, d8` - Add value to register
    ///
    /// - parameter register: the register to add to
    /// - parameter value:    the value to be added
    public mutating func ADD(_ register: inout UInt8, _ value: UInt8) {
        let high = UInt16(register) &+ UInt16(value)
        let low  = (register & 0x0F) &+ (value & 0x0F)

        ZFlag = high == 0
        NFlag = false
        HFlag = low > 0x0F
        CFlag = high > 0xFF

        register = register &+ value
    }

    /// `ADD r, (a16)` - Add value at address to register
    ///
    /// - parameter register: the register to add to
    /// - parameter address:  the address of the value to be added
    public mutating func ADD(_ register: inout UInt8, address: Address) {
        ADD(&register, memory.read(address))
    }

    /// `AND r, d8` - Logical AND value with register
    ///
    /// - parameter register: the register to be written to
    /// - parameter value:    the value to AND with the register
    public mutating func AND(_ register: inout UInt8, _ value: UInt8) {
        register = register & value

        ZFlag = register == 0
        NFlag = false
        HFlag = true
        CFlag = false
    }

    /// `AND r, (a16)` - Logical AND value at address with register
    ///
    /// - parameter register: the register to be written to
    /// - parameter address:  the address of the value to AND with the register
    public mutating func AND(_ register: inout UInt8, address: Address) {
        AND(&A, memory.read(address))
    }

    /// `LD r, d8` - Load 8-bit value into register
    ///
    /// - parameter register: the register to be written to
    /// - parameter value:    an 8-bit value to write to the register
    public mutating func LD(_ register: inout UInt8, _ value: UInt8) {
        register = value
    }

    /// `LD r, d16` - Load 16-bit value into register
    ///
    /// - parameter register: the register to be written to
    /// - parameter value:    a 16-bit value to write to the register
    public mutating func LD(_ register: inout UInt16, _ value: UInt16) {
        register = value
    }

    /// `LD (a16), d8` - Write 8-bit value to memory
    ///
    /// - parameter address: the memory address to be written to
    /// - parameter value:   the value to be written
    public mutating func LD(address: Address, _ value: UInt8) {
        memory.write(address, value)
    }

    /// `LD (a16), d16` - Write 16-bit value to memory
    ///
    /// - parameter address: the memory address to be written to
    /// - parameter value:   the value to be written
    public mutating func LD(address: Address, _ value: UInt16) {
        memory.write16(address, value)
    }

    /// `LD r, (a16)` - Read memory to register
    ///
    /// - parameter register: the register to be written to
    /// - parameter address:  the address of the value to be written
    public mutating func LD(_ register: inout UInt8, address: Address) {
        register = memory.read(address)
    }

    /// `LD ($FF00 + a8), d8` - Write value to memory at offset from 0xFF00
    ///
    /// - note: Used for quick writes to I/0 ports, zero page RAM and interrupt register
    /// - seealso: [Memory](http://extremely.online/GameBro/Structs/Memory.html)
    /// - parameter offset: the address offset from 0xFF00
    /// - parameter value:  the value to be written
    public mutating func LDH(offset: UInt8, _ value: UInt8) {
        let address = Address(0xFF, offset)
        memory.write(address, value)
    }

    /// `LD r, ($FF00 + a8)` - Read value from memory at offset from 0xFF00 into register
    ///
    /// - note: Used for quick writes to I/0 ports, zero page RAM and interrupt register
    /// - seealso: [Memory](http://extremely.online/GameBro/Structs/Memory.html)
    /// - parameter register: the register to be written to
    /// - parameter offset:   the address offset from 0xFF00
    public mutating func LDH(_ register: inout UInt8, offset: UInt8) {
        let address = Address(0xFF, offset)
        register = memory.read(address)
    }

    /// `LD HL, ($FF00 + a8)` - Read 16-bit valuw from memory at offset from 0xFF00 into HL register
    ///
    /// - note: Used for quick writes to I/0 ports, zero page RAM and interrupt register
    /// - seealso: [Memory](http://extremely.online/GameBro/Structs/Memory.html)
    /// - parameter offset:   the address offset from 0xFF00
    public mutating func LDHL(offset: Int8) {
        ZFlag = false
        NFlag = false

        let absoluteOffset: Address = Address(abs(offset))
        let address: Address

        if offset >= 0 {
            address = SP &+ absoluteOffset
            CFlag = (SP & 0x00FF) + absoluteOffset > 0xFF
            HFlag = (SP & 0x000F) + absoluteOffset > 0xF
        } else {
            address = SP &- absoluteOffset
            CFlag = (address & 0x00FF) <= (SP & 0x00FF)
            HFlag = (address & 0x000F) <= (SP & 0x000F)
        }

        HL = address
    }

    /// `NOP` - Do nothing
    public func NOP() {}

    /// `OR r, d8` - Logical OR value with register
    ///
    /// - parameter register: the register to be written to
    /// - parameter value:    the value to OR with the register
    public mutating func OR(_ register: inout UInt8, _ value: UInt8) {
        register = register | value

        ZFlag = register == 0
        NFlag = false
        HFlag = false
        CFlag = false
    }

    /// `OR r, (a16)` - Logical OR value at address with register
    ///
    /// - parameter register: the register to be written to
    /// - parameter address:  the address of the value to OR with the register
    public mutating func OR(_ register: inout UInt8, address: Address) {
        OR(&register, memory.read(address))
    }

    /// `PUSH d16` - Push a value onto the stack
    ///
    /// - parameter value: the value to push onto the stack
    public mutating func PUSH(_ value: UInt16) {
        SP -= 2
        memory.write16(SP, value)
    }

    /// `POP r` - Pop a value off the stack
    ///
    /// - parameter register: the double-width register to write the popped value to
    public mutating func POP(_ register: inout UInt16) {
        register = memory.read16(SP)
        SP += 2
    }

    /// `SBC r, d8` - Subtract value and carry bit from register
    ///
    /// - parameter register: the register to be subtracted from
    /// - parameter value:    the value to be subtracted
    public mutating func SBC(_ register: inout UInt8, _ value: UInt8) {
        let carry: UInt8 = CFlag ? 1 : 0
        let high = UInt16(register) &- UInt16(value) &- UInt16(carry)
        let low  = (register & 0x0F) &- (value & 0x0F) &- carry

        ZFlag = high == 0
        NFlag = true
        HFlag = low > 0x0F
        CFlag = high > 0xFF

        register = register &- value &- carry
    }

    /// `SBC r, (a16)` - Subtract value and carry bit from register
    ///
    /// - parameter register: the register to be subtracted from
    /// - parameter address:  the address of the value to be subtracted
    public mutating func SBC(_ register: inout UInt8, address: Address) {
        ADC(&register, memory.read(address))
    }

    /// `SUB r, d8` - Subtract value from register
    ///
    /// - parameter register: the register to be subtracted from
    /// - parameter value:    the value to be subtracted
    public mutating func SUB(_ register: inout UInt8, _ value: UInt8) {
        let high = UInt16(register) &- UInt16(value)
        let low  = (register & 0x0F) &- (value & 0x0F)

        ZFlag = high == 0
        NFlag = true
        HFlag = low > 0x0F
        CFlag = high > 0xFF

        register = register &- value
    }

    /// `SUB r, (a16)` - Subtract value at address from register
    ///
    /// - parameter register: the register to be subtracted from
    /// - parameter address:  the address of the value to be subtracted
    public mutating func SUB(_ register: inout UInt8, address: Address) {
        SUB(&register, memory.read(address))
    }

    /// `XOR r, d8` - Logical XOR value with register
    ///
    /// - parameter register: the register to be written to
    /// - parameter value:    the value to XOR with the register
    public mutating func XOR(_ register: inout UInt8, _ value: UInt8) {
        register = register ^ value

        ZFlag = register == 0
        NFlag = false
        HFlag = false
        CFlag = false
    }

    /// `XOR r, (a16)` - Logical XOR value at address with register
    ///
    /// - parameter register: the register to be written to
    /// - parameter address:  the address of the value to XOR with the register
    public mutating func XOR(_ register: inout UInt8, address: Address) {
        XOR(&register, memory.read(address))
    }

}
