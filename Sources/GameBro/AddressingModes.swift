public extension CPU {

    /// Get the value at the BC register and increment the program counter, spending the specified number of cycles
    ///
    /// - parameter cyclesSpent: the number of CPU cycles spent by this operation
    ///
    /// - returns: the value of the BC register
    public mutating func absoluteBC(cycles cyclesSpent: UInt64) -> UInt8 {
        let operand = memory.read(BC)

        cycle += cyclesSpent
        PC += 1

        return operand
    }

    /// Get the value at the DE register and increment the program counter, spending the specified number of cycles
    ///
    /// - parameter cyclesSpent: the number of CPU cycles spent by this operation
    ///
    /// - returns: the value of the DE register
    public mutating func absoluteDE(cycles cyclesSpent: UInt64) -> UInt8 {
        let operand = memory.read(DE)

        cycle += cyclesSpent
        PC += 1

        return operand
    }

    /// Get the value at the HL register and increment the program counter, spending the specified number of cycles
    ///
    /// - parameter cyclesSpent: the number of CPU cycles spent by this operation
    ///
    /// - returns: the value of the HL register
    public mutating func absoluteHL(cycles cyclesSpent: UInt64) -> UInt8 {
        let operand = memory.read(HL)

        cycle += cyclesSpent
        PC += 1

        return operand
    }

    /// Get the value at the HL register, decrement the HL register, and increment the program counter, spending the
    /// specified number of cycles
    ///
    /// - parameter cyclesSpent: the number of CPU cycles spent by this operation
    ///
    /// - returns: the value of the HL register prior to decrementing
    public mutating func absoluteHLD(cycles cyclesSpent: UInt64) -> Address {
        let address = Address(HL)
        HL -= 1

        cycle += cyclesSpent
        PC += 1

        return address
    }

    /// Get the value at the HL register, increment the HL register, and increment the program counter, spending the
    /// specified number of cycles
    ///
    /// - parameter cyclesSpent: the number of CPU cycles spent by this operation
    ///
    /// - returns: the value of the HL register prior to incrementing
    public mutating func absoluteHLI(cycles cyclesSpent: UInt64) -> Address {
        let address = Address(HL)
        HL += 1

        cycle += cyclesSpent
        PC += 1

        return address
    }

    
    /// Get the value of the byte immeditaely after the current program counter location, then increment the program 
    /// counter twice.
    ///
    /// - parameter cyclesSpent: the number of CPU cycles spent by this operation
    ///
    /// - returns: the value of the byye immediately after the program counter
    public mutating func immediate(cycles cyclesSpent: UInt64) -> UInt8 {
        let operand = memory.read(PC &+ 1)

        cycle += cyclesSpent
        PC += 2

        return operand
    }

    /// Get the value of the two bytes immeditaely after the current program counter location, then increment the
    /// program counter thrice.
    ///
    /// - parameter cyclesSpent: the number of CPU cycles spent by this operation
    ///
    /// - returns: the value of the two byyes immediately after the program counter
    public mutating func immediate16(cycles cyclesSpent: UInt64) -> UInt16 {
        let low  = memory.read(PC &+ 1)
        let high = memory.read(PC &+ 2)
        let operand = UInt16(high) << 8 | UInt16(low)

        cycle += cyclesSpent
        PC += 3

        return operand
    }

    /// Get the value of the byte immeditaely after the current program counter location, interpreted as a signed 
    /// integer, then increment the program counter twice.
    ///
    /// - parameter cyclesSpent: the number of CPU cycles spent by this operation
    ///
    /// - returns: the value of the byye immediately after the program counter, interpreted as a signed integer
    public mutating func immediateSigned(cycles cyclesSpent: UInt64) -> Int8 {
        let operand = Int8(bitPattern: memory.read(PC &+ 1))

        cycle += cyclesSpent
        PC += 2

        return operand
    }

    /// Spend the specified number of cycles. Used to implement instructions that don't involve data access.
    ///
    /// - parameter cyclesSpent: the number of CPU cycles spent by this operation
    public mutating func implied(cycles cyclesSpent: UInt64) {
        cycle += cyclesSpent
        PC += 1
    }

    /// Get the value of the specified register and increment the program counter.
    ///
    /// - parameter register:    the register to return a value from
    /// - parameter cyclesSpent: the number of CPU cycles spent by this operation
    ///
    /// - returns: the value of the specified register
    public mutating func register(_ register: UInt8, cycles cyclesSpent: UInt64) -> UInt8 {
        cycle += cyclesSpent
        PC += 1

        return register
    }

    /// Get the value of the specified double-width register and increment the program counter.
    ///
    /// - parameter register:    the double-width register to return a value from
    /// - parameter cyclesSpent: the number of CPU cycles spent by this operation
    ///
    /// - returns: the value of the specified double-width register
    public mutating func register16(_ register: UInt16, cycles cyclesSpent: UInt64) -> UInt16 {
        cycle += cyclesSpent
        PC += 1

        return register
    }
}
