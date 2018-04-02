//
//  CreatureHiddenTraits.swift
//  
//
//  Created by Guillermo Cique Fernández on 31/3/18.
//

public extension Creature {
    public var intelligence: Double {
        let intelligenceBitData = genotype[5..<8]
        return Double(intelligenceBitData)
    }
    public var luck: Double {
        let luckBitData = genotype[3..<6]
        return Double(luckBitData)
    }
    public var strength: Double {
        let strengthBitData = genotype[0..<3]
        return Double(strengthBitData)
    }
}
