//
//  CreatureVisibleTraits.swift
//  
//
//  Created by Guillermo Cique Fernández on 31/3/18.
//

import SpriteKit

public enum EyeType: BitData {
    case dot = 0b00
    case circle = 0b01
    case triangle = 0b10
    case square = 0b11
}

public enum MouthType: BitData {
    case mustache = 0b00
    case line = 0b01
    case happy = 0b10
    case surprised = 0b11
}

public enum BodyType: BitData {
    case triangle = 0b00
    case circle = 0b01
    case square = 0b10
    case star = 0b11
}

public enum Color: BitData {
    case red = 0b0000
    case orange = 0b0001
    case yellow = 0b0010
    case green = 0b0011
    case blue = 0b0100
    case purple = 0b0101
    case brown = 0b0110
    case pink = 0b0111
}

public extension Creature {
    public var eyeType: EyeType {
        get {
            let eyeBitData = genotype[6..<8]
            return EyeType(rawValue: eyeBitData)!
        }
        set {
            genotype[6..<8] = newValue.rawValue
        }
    }
    public var mouthType: MouthType {
        get {
            let mouthBitData = genotype[4..<6]
            return MouthType(rawValue: mouthBitData)!
        }
        set {
            genotype[4..<6] = newValue.rawValue
        }
    }
    public var bodyType: BodyType {
        get {
            let shapeBitData = genotype[2..<4]
            return BodyType(rawValue: shapeBitData)!
        }
        set {
            genotype[2..<4] = newValue.rawValue
        }
    }
    public var borderSize: CGFloat {
        let borderBitData = genotype[0..<2]
        return (1 + CGFloat(borderBitData)) * 3
    }
    public var color: SKColor {
        let colorBitData = genotype[0..<4]
        let hue: CGFloat = CGFloat(colorBitData) * 0.22
        let saturation: CGFloat = 0.8
        let brightness: CGFloat = 0.8
        
        return SKColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
    public var borderColor: SKColor {
        let colorBitData = genotype[0..<4]
        let hue: CGFloat = CGFloat(colorBitData) * 0.22 + 0.05
        let saturation: CGFloat = 0.7
        let brightness: CGFloat = 0.85
        
        return SKColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 0.8)
    }
}