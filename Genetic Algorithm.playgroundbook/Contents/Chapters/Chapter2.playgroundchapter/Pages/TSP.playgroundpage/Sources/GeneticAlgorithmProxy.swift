//
//  GeneticAlgorithmProxy.swift
//  
//
//  Created by Guillermo Cique Fernández on 31/3/18.
//

import UIKit

public class GeneticAlgorithmProxy {
    var isRunning = false
    var isInitialized = false
    var currentGeneration = 0
    var cities: [City] = []
    public var generateRandomPopulationBlock: (([City]) -> Void)!
    public var evolveBlock: ((Int) -> Void)!
    
    public init() {}
    
    public func initialize(cities: [City]) -> Bool {
        stop()
        guard !cities.isEmpty else {
            return false
        }
        
        generateRandomPopulationBlock(cities)
        
        isInitialized = true
        currentGeneration = 0
        start()

        return true
    }
    
    public func start() {
        guard !isRunning else {
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            self.isRunning = true
            while self.isRunning {
                self.currentGeneration += 1
                self.evolveBlock(self.currentGeneration)
            }
        }
    }
    
    public func pause() {
        isRunning = false
    }
    
    public func stop() {
        isRunning = false
        isInitialized = false
    }
}
