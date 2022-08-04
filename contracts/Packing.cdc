pub contract Packing {
    
    pub fun pack(a: AnyStruct, b: AnyStruct): [UInt8] {
        // Only assuming to have Address and UFix64 for the pack
        let _a: Address? = a as? Address
        let _b: UFix64? = b as? UFix64

        // Convert _a to bytes
        if _a != nil && _b != nil {
            let aStream = _a!.toBytes()
            let bStream = _b!.toBigEndianBytes()
            return aStream.concat(bStream)
        }
        return [];
    }

    init() {}
}