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

    /// `CP r, d8` - Compare value with register
    ///
    /// - parameter register: the register to be compared to
    /// - parameter value:    the value to be compared
    public mutating func CP(_ register: inout UInt8, _ value: UInt8) {
        ZFlag = register &- value == 0
        NFlag = true
        HFlag = Int(register & 0xF) - Int(value & 0xF) < 0
        CFlag = Int(register) - Int(value) < 0
    }

    /// `CP r, d8` - Compare value at address with register
    ///
    /// - parameter register: the register to be compared to
    /// - parameter address:  the address of the value to be compared
    public mutating func CP(_ register: inout UInt8, address: Address) {
        CP(&register, memory.read(address))
    }

    /// `DEC r` - Decrement the value in the provided register
    ///
    /// - parameter register: The register to be decremented
    public mutating func DEC(_ register: inout UInt8) {
        ZFlag = register &- 1 == 0
        NFlag = false
        HFlag = (register & 0x0F) &- 1 > 0x0F

        register = register &- 1
    }

    /// `DEC (a16)` - Decrement the value at the provided memory location
    ///
    /// - parameter address: The address of the value to be decremented
    public mutating func DEC(address: Address) {
        let value = memory.read(address)

        ZFlag = value &- 1 == 0
        NFlag = false
        HFlag = (value & 0x0F) &- 1 > 0x0F

        memory.write(address, value &- 1)
    }

    /// `INC r` - Increment the value in the provided register
    ///
    /// - parameter register: The register to be incremented
    public mutating func INC(_ register: inout UInt8) {
        ZFlag = register &+ 1 == 0
        NFlag = false
        HFlag = (register & 0x0F) &+ 1 > 0x0F

        register = register &+ 1
    }

    /// `INC (a16)` - Increment the value at the provided memory location
    ///
    /// - parameter address: The address of the value to be incremented
    public mutating func INC(address: Address) {
        let value = memory.read(address)

        ZFlag = value &+ 1 == 0
        NFlag = false
        HFlag = (value & 0x0F) &+ 1 > 0x0F

        memory.write(address, value &+ 1)
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
        let address = Address(page: 0xFF, offset: offset)
        memory.write(address, value)
    }

    /// `LD r, ($FF00 + a8)` - Read value from memory at offset from 0xFF00 into register
    ///
    /// - note: Used for quick writes to I/0 ports, zero page RAM and interrupt register
    /// - seealso: [Memory](http://extremely.online/GameBro/Structs/Memory.html)
    /// - parameter register: the register to be written to
    /// - parameter offset:   the address offset from 0xFF00
    public mutating func LDH(_ register: inout UInt8, offset: UInt8) {
        let address = Address(page: 0xFF, offset: offset)
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

        ZFlag = register &- value &- carry == 0
        NFlag = true
        HFlag = Int(register & 0xF) - Int(value & 0xF) - Int(carry) < 0
        CFlag = Int(register) - Int(value) - Int(carry) < 0

        register = register &- value &- carry
    }

    /// `SBC r, (a16)` - Subtract value and carry bit from register
    ///
    /// - parameter register: the register to be subtracted from
    /// - parameter address:  the address of the value to be subtracted
    public mutating func SBC(_ register: inout UInt8, address: Address) {
        SBC(&register, memory.read(address))
    }

    /// `SUB r, d8` - Subtract value from register
    ///
    /// - parameter register: the register to be subtracted from
    /// - parameter value:    the value to be subtracted
    public mutating func SUB(_ register: inout UInt8, _ value: UInt8) {
        ZFlag = register &- value == 0
        NFlag = true
        HFlag = Int(register & 0xF) - Int(value & 0xF) < 0
        CFlag = Int(register) - Int(value) < 0

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
