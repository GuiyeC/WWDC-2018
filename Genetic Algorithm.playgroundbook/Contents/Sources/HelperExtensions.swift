//
//  HelperExtensions.swift
//
//
//  Created by Guillermo Cique Fernández on 31/3/18.
//

import Foundation

public func random(from: Int = 0, to: Int) -> Int {
    return Int(arc4random_uniform(UInt32(to - from))) + from
}

public extension Bool {
    init(probability: Int) {
        self = random(to: 100) < probability
    }
}

public extension Array {
    func randomItem() -> Element {
        assert(!isEmpty, "Array is empty")
        
        let randomIndex = random(to: count)
        return self[randomIndex]
    }
    
    mutating func shuffle() {
        for i in 0..<count {
            let randomIndex = random(to: count)
            swapAt(i, randomIndex)
        }
    }
    
    func shuffled() -> [Element] {
        var copy = self
        copy.shuffle()
        return copy
    }
    
}