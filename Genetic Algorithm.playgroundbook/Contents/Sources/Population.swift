//
//  Population.swift
//
//
//  Created by Guillermo Cique Fernández on 31/3/18.
//

import Foundation

public extension Array where Element: Individual {
    
    func bestIndividual() -> Element {
        assert(!isEmpty, "Population is empty")
        
        return self.max()!
    }
    
    func select() -> [Element] {
        var selectedPopulation: [Element] = []
        
        for _ in 0..<count {
            let individual1 = randomItem()
            let individual2 = randomItem()
            
            let best = Swift.max(individual1, individual2)
            selectedPopulation.append(best)
        }
        
        return selectedPopulation
    }
    
    mutating func cross(by crossoverPercentage: Int, _ crossBlock: ((Element, Element) -> (Element, Element))? = nil) {
        let block = crossBlock ?? { $0.cross(with: $1) }
        
        var selectedForCrossover: [Int] = []
        
        for i in 0..<count {
            if Bool(probability: crossoverPercentage) {
                selectedForCrossover.append(i)
            }
        }
        
        // If there are even selections, remove one randomly
        if selectedForCrossover.count % 2 == 1 {
            let randomIndex = random(to: selectedForCrossover.count)
            selectedForCrossover.remove(at: randomIndex)
        }
        
        for (x, y) in zip(selectedForCrossover, selectedForCrossover.dropFirst()) {
            let parent1 = self[x]
            let parent2 = self[y]
            
            let descendants = block(parent1, parent2)
            
            // Replace parents with descendants
            self[x] = descendants.0
            self[y] = descendants.1
        }
    }
    
    mutating func mutate(by mutationPercentage: Int, _ mutationBlock: ((Element, Int) -> Element)? = nil) {
        let block: ((inout Element, Int) -> Void)
        if let mutationBlock = mutationBlock {
            block = { $0 = mutationBlock($0, $1) }
        }
        else {
            block = { $0.mutate(by: $1); return }
        }
        
        for i in 0..<count {
            block(&self[i], mutationPercentage)
        }
    }
    
    mutating func evaluate(_ evaluationBlock: ((Element) -> Double)? = nil) {
        let block: ((inout Element) -> Void)
        if let evaluationBlock = evaluationBlock {
            block = { $0.fitness = evaluationBlock($0) }
        }
        else {
            block = { $0.evaluate(); return }
        }
        
        for i in 0..<count {
            block(&self[i])
        }
    }
}
