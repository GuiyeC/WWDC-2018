//
//  Individual.swift
//
//
//  Created by Guillermo Cique Fernández on 31/3/18.
//

import Foundation

public protocol Individual: Comparable {
    associatedtype Genotype
    
    var genotype: Genotype { get set }
    var fitness: Double { get set }
    
    init(genotype: Genotype)
    
    func cross(with other: Self) -> (Self, Self)
    mutating func mutate(by mutationPercentage: Int)
    mutating func evaluate()
}

public extension Individual {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.fitness == rhs.fitness
    }
    
    static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.fitness < rhs.fitness
    }
}

