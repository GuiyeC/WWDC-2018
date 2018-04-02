//
//  BitData.swift
//
//
//  Created by Guillermo Cique Fernández on 31/3/18.
//

import Foundation

public enum BitValue {
    case zero
    case one
}

public typealias BitData = UInt8

extension BitData: RandomAccessCollection {
    public var count: Int { return MemoryLayout<BitData>.size * 8 }
    public var startIndex: Int { return 0 }
    public var endIndex: Int { return count }
    
    public subscript(index: Int) -> BitValue {
        get {
            assert(checkValid(index: index), "Index out of range: \(index)")
            
            return self & mask(index: index) != 0 ? .one : .zero
        }
        set(newValue) {
            assert(checkValid(index: index), "Index out of range: \(index)")
            
            guard self[index] != newValue else {
                return
            }
            
            self ^= mask(index: index)
        }
    }
    
    public subscript(range: Range<Int>) -> BitData {
        get {
            assert(checkValid(range: range), "Index out of range: \(range)")
            guard range.count > 0 else {
                return 0
            }
            
            let rightGap = range.lowerBound
            let leftGap = count - range.upperBound
            
            // Clean 0s on the left
            var result: BitData = self << leftGap
            // Move back to the right
            result >>= leftGap
            // Shift right to the starting position
            result >>= rightGap
            
            return result
        }
        set(newValue) {
            assert(checkValid(range: range), "Index out of range: \(range)")
            guard range.count > 0 else {
                return
            }
            
            let dataMask = mask(range: range)
            // Clean and position newValue
            let cleanData = newValue << range.lowerBound & dataMask
            // Clean positions taken by newValue
            self &= ~dataMask
            // Update data
            self |= cleanData
        }
    }
    
    public func makeIterator() -> AnyIterator<BitValue> {
        var index = 0
        return AnyIterator {
            guard self.checkValid(index: index) else {
                return nil
            }
            
            let value = self[index]
            index += 1
            return value
        }
    }
}

public extension BitData {
    mutating func flip(at index: Int) {
        self[index] = self[index] == .zero ? .one : .zero
    }
}

private extension BitData {
    private func mask(index: Int) -> BitData {
        return 1 << index
    }

    private func mask(range: Range<Int>) -> BitData {
        guard range.count > 0 else {
            return 0
        }
        return mask(from: range.lowerBound, to: range.lowerBound + range.count - 1)
    }
    
    private func mask(from: Int, to: Int) -> BitData {
        return ((1 << (to - from)) - 1) << from
    }
    
    private func checkValid(index: Int) -> Bool {
        return index >= 0 && index < count
    }
    
    private func checkValid(range: Range<Int>) -> Bool {
        return checkValid(index: range.lowerBound) && (range.count == 0 || checkValid(index: range.lowerBound + range.count - 1))
    }
}

extension BitData: CustomDebugStringConvertible {
    public var debugDescription: String {
        return String(self, radix: 2)
    }
}
