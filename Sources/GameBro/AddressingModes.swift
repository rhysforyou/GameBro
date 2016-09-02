public extension CPU {
    public mutating func absoluteBC(cycles cyclesSpent: UInt64) -> UInt8 {
        let operand = memory.read(BC)

        cycle += cyclesSpent
        PC += 1

        return operand
    }

    public mutating func absoluteDE(cycles cyclesSpent: UInt64) -> UInt8 {
        let operand = memory.read(DE)

        cycle += cyclesSpent
        PC += 1

        return operand
    }

    public mutating func absoluteHL(cycles cyclesSpent: UInt64) -> UInt8 {
        let operand = memory.read(HL)

        cycle += cyclesSpent
        PC += 1

        return operand
    }

    public mutating func absoluteHLD(cycles cyclesSpent: UInt64) -> Address {
        let address = Address(HL)
        HL -= 1

        cycle += cyclesSpent
        PC += 1

        return address
    }

    public mutating func absoluteHLI(cycles cyclesSpent: UInt64) -> Address {
        let address = Address(HL)
        HL += 1

        cycle += cyclesSpent
        PC += 1

        return address
    }

    public mutating func immediate(cycles cyclesSpent: UInt64) -> UInt8 {
        let operand = memory.read(PC &+ 1)

        cycle += cyclesSpent
        PC += 2

        return operand
    }

    public mutating func immediate16(cycles cyclesSpent: UInt64) -> UInt16 {
        let low  = memory.read(PC &+ 1)
        let high = memory.read(PC &+ 2)
        let operand = UInt16(high) << 8 | UInt16(low)

        cycle += cyclesSpent
        PC += 3

        return operand
    }

    public mutating func immediateSigned(cycles cyclesSpent: UInt64) -> Int8 {
        let operand = Int8(bitPattern: memory.read(PC &+ 1))

        cycle += cyclesSpent
        PC += 2

        return operand
    }

    public mutating func implied(cycles cyclesSpent: UInt64) {
        cycle += cyclesSpent
        PC += 1
    }

    public mutating func register(_ register: UInt8, cycles cyclesSpent: UInt64) -> UInt8 {
        cycle += cyclesSpent
        PC += 1

        return register
    }

    public mutating func register16(_ register: UInt16, cycles cyclesSpent: UInt64) -> UInt16 {
        cycle += cyclesSpent
        PC += 1

        return register
    }
}
