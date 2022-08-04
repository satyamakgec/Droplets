pub struct Bytes32 {

    pub var value: [UInt8]

    init(_ value: [UInt8]) {
        pre {
            value.length == 32: "For Bytes32 length should be 32"
        }
        self.value = value
    }

    pub fun toString() : String {
        return String.encodeHex(self.value)
    }

    pub fun concat(target: Bytes32) : [UInt8] {
        return self.value.concat(target.value)
    }

    pub fun gt(target: Bytes32) : Bool {
        for index, byte in self.value {
            if byte > target.value[index] {
                return true
            } else if byte < target.value[index] {
                return false
            }
        }
        return false
    }

    pub fun lt(target: Bytes32) : Bool {
        for index, byte in self.value {
            if byte < target.value[index] {
                return true
            } else if byte > target.value[index] {
                return false
            }
        }
        return false
    }

   pub fun eq(target: Bytes32) : Bool {
        return self.toString() == target.toString()
    }

}