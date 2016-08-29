public extension CPU {
    
    /// `ADC r, d8`
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
    
    /// `ADC r, (a16)`
    public mutating func ADC(_ register: inout UInt8, address: Address) {
        ADC(&register, memory.read(address))
    }
    
    /// `ADD r, d8`
    public mutating func ADD(_ register: inout UInt8, _ value: UInt8) {
        let high = UInt16(register) &+ UInt16(value)
        let low  = (register & 0x0F) &+ (value & 0x0F)
        
        ZFlag = high == 0
        NFlag = false
        HFlag = low > 0x0F
        CFlag = high > 0xFF
        
        register = register &+ value
    }
    
    /// `ADD r, (a16)`
    public mutating func ADD(_ register: inout UInt8, address: Address) {
        ADD(&register, memory.read(address))
    }
    
    /// `LD nn, n` - 8-bit load into register
    public mutating func LD(_ register: inout UInt8, _ value: UInt8) {
        register = value
    }
    
    // `LD n, nn` - 16-bit load into register
    public mutating func LD(_ register: inout UInt16, _ value: UInt16) {
        register = value
    }
    
    /// `LD (C), A` - Write register to memory
    public mutating func LD(address: Address, _ value: UInt8) {
        memory.write(address, value)
    }
    
    /// `LD (C), A` - Write register to memory
    public mutating func LD(address: Address, _ value: UInt16) {
        memory.write16(address, value)
    }
    
    /// `LD A, (C)` - Read memory to register
    public mutating func LD(_ register: inout UInt8, address: Address) {
        register = memory.read(address)
    }
    
    public mutating func LDH(offset: UInt8, _ value: UInt8) {
        let address = Address(0xFF, offset)
        memory.write(address, value)
    }
    
    public mutating func LDH(_ register: inout UInt8, offset: UInt8) {
        let address = Address(0xFF, offset)
        register = memory.read(address)
    }
    
    public mutating func LDHL(offset: Int8) {
        ZFlag = false
        NFlag = false
        
        let absoluteOffset: Address = Address(abs(offset))
        let address: Address
        
        if (offset >= 0) {
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
    
    public func NOP() {}
    
    public mutating func PUSH(_ value: UInt16) {
        SP -= 2
        memory.write16(SP, value)
    }
    
    public mutating func POP(_ register: inout UInt16) {
        register = memory.read16(SP)
        SP += 2
    }
    
    
    
    /// `ADC r, d8`
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
    
    /// `ADC r, (a16)`
    public mutating func SBC(_ register: inout UInt8, address: Address) {
        ADC(&register, memory.read(address))
    }
    
    /// `ADD r, d8`
    public mutating func SUB(_ register: inout UInt8, _ value: UInt8) {
        let high = UInt16(register) &- UInt16(value)
        let low  = (register & 0x0F) &- (value & 0x0F)
        
        ZFlag = high == 0
        NFlag = true
        HFlag = low > 0x0F
        CFlag = high > 0xFF
        
        register = register &- value
    }
    
    /// `ADD r, (a16)`
    public mutating func SUB(_ register: inout UInt8, address: Address) {
        ADD(&register, memory.read(address))
    }
    
}
