//
//  Creature.swift
//  
//
//  Created by Guillermo Cique Fernández on 31/3/18.
//

public func randomCreature() -> Creature {
    let randomGenotype = BitData(random(to: Int(BitData.max)))
    return Creature(genotype: randomGenotype)
}

public func generateRandomPopulation(of populationSize: Int) -> [Creature] {
    return (0..<populationSize).map { _ in randomCreature() }
}

public struct Creature: Individual {
    public var genotype: BitData
    public var fitness: Double = 0
    
    public init(genotype: BitData) {
        self.genotype = genotype
    }
    
    func cross(_ data1: BitData, with data2: BitData, crossPoint: Int) -> BitData {
        let newData = data1[0..<crossPoint] | data2[crossPoint..<data2.count]
        return newData
    }
    
    public func cross(with other: Creature) -> (Creature, Creature) {
        let genotypeSize = self.genotype.count
        let crossPoint = random(to: genotypeSize)
        
        let newData1 = cross(self.genotype, with: other.genotype, crossPoint: crossPoint)
        let newData2 = cross(other.genotype, with: self.genotype, crossPoint: crossPoint)
        
        let descendant1 = Creature(genotype: newData1)
        let descendant2 = Creature(genotype: newData2)
        
        return (descendant1, descendant2)
    }
    
    public mutating func mutate(by mutationPercentage: Int = 3) {
        for index in 0..<genotype.count {
            if Bool(probability: mutationPercentage) {
                genotype.flip(at: index)
            }
        }
    }
    
    public mutating func evaluate() {
        fitness = 0
    }
}
