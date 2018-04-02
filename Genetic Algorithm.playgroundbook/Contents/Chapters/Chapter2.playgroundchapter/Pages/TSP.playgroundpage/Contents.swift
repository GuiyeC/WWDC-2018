//#-hidden-code
//
//  Contents.swift
//
//  Created by Guillermo Cique Fernández on 31/3/18.
//
//#-end-hidden-code
/*:
 We've seen the basic implementation of a Genetic Algorithm:
 * Generate a random population.
 * **Evaluate** each individual.
 * **Select** a new population.
 * **Cross** individuals from the new population.
 * **Mutate** to add variety.
 * And **repeat**.

 Repeat as much as we want, until we find the optiomal solution or at least one we are happy with.

 With the basics down, let's get into real life applications of the Genetic Algorithm. Genetic Algorithms can be used to calculate class schedules, get the best times to go grocery shopping, create the best antennas or airplane wings possible...
 
 We are gonna look at a well known problem,  the **Travelling Salesman Problem** or TSP for short.

 You are a salesman and you want to visit a number of cities before returning to your hometown, and you want to travel the shortest distance possible.
 
 This might look like a really simple problem, you might just pick the map and try to find the route yourself, but, how will you know if it's the best route? It might be easy to check if you only want to visit 3 cities, but it gets impossible when you try to visit 20 for example.

 You can play around as much as you like with this code, it has a completely new individual, a ```Tour``` with a ```Route``` as it's genotype. We can no longer use the same crossover and mutation algorithms, we don't want to repeat cities in our genotypes. Take that into account and most importantly, have fun!

 */ 
//#-hidden-code
import UIKit
import PlaygroundSupport
//#-end-hidden-code

let populationSize = 200
let crossoverPercentage = 60
let mutationPercentage = 3
//#-hidden-code
public struct Tour: Individual {
    public var genotype: Route
    public var fitness: Double = 0
    
    public init(genotype: Route) {
        self.genotype = genotype
    }
//#-end-hidden-code

func cross(_ route1: Route, with route2: Route, crossPoint: Int) -> Route {
//#-editable-code
    var route = Route(route1[0..<crossPoint])
    
    for city in route2 {
        if !route.contains(city) {
            route.append(city)
        }
    }
    
    return route
//#-end-editable-code
}
    
public func cross(with other: Tour) -> (Tour, Tour) {
//#-editable-code
    let genotypeSize = self.genotype.count
    let crossPoint = random(to: genotypeSize)
    
    let route1 = self.genotype
    let route2 = other.genotype
    
    let newRoute1 = cross(route1, with: route2, crossPoint: crossPoint)
    let newRoute2 = cross(route2, with: route1, crossPoint: crossPoint)
    
    let descendant1 = Tour(genotype: newRoute1)
    let descendant2 = Tour(genotype: newRoute2)
    
    return (descendant1, descendant2)
//#-end-editable-code
}
  
public mutating func mutate(by mutationPercentage: Int) {
//#-editable-code
    for index in 0..<genotype.count {
        if Bool(probability: mutationPercentage) {
            let randomIndex = random(to: genotype.count)
            genotype.swapAt(index, randomIndex)
        }
    }
//#-end-editable-code
}

//#-hidden-code
    private func distance(from: City, to: City) -> Double {
        return Double(sqrt(pow(from.x - to.x, 2) + pow(from.y - to.y, 2)))
    }
    
    public mutating func evaluate() {
        var totalDistance: Double = 0
        for (x, y) in zip(genotype, genotype.dropFirst()) {
            totalDistance += distance(from: x, to: y)
        }
        
        // Close the loop
        if let firstCity = genotype.first, let lastCity = genotype.last {
            totalDistance += distance(from: firstCity, to: lastCity)
        }
        
        fitness = totalDistance
    }
    
    public static func < (lhs: Tour, rhs: Tour) -> Bool {
        // Less is better
        return lhs.fitness > rhs.fitness
    }
    
}

//#-end-hidden-code
func evolve(population: [Tour]) -> [Tour] {
//#-editable-code
    var newPopulation = population.select()
    newPopulation.cross(by: crossoverPercentage)
    newPopulation.mutate(by: mutationPercentage)
    newPopulation.evaluate()
    
    return newPopulation
//#-end-editable-code
}

//#-hidden-code
let viewController = TSPViewController()
let geneticAlgorithmProxy = GeneticAlgorithmProxy()
viewController.geneticAlgorithmProxy = geneticAlgorithmProxy

var population: [Tour] = []
var bestIndividual: Tour!
var onGenerationBlock: ((Int, Double, Route) -> Void)!

func generateRandomPopulation(cities: [City]) {
    func randomIndividual() -> Tour {
        let randomRoute = cities.shuffled()
        return Tour(genotype: randomRoute)
    }
    
    population = (0..<populationSize).map { _ in randomIndividual() }
    population.evaluate()
    bestIndividual = population.bestIndividual()
    viewController.updateBestRoute(distance: bestIndividual.fitness, route: bestIndividual.genotype)
    viewController.updateGeneration(generation: 0)
}

func evolve(generation: Int) {
    population = evolve(population: population)
    let bestOfGeneration = population.bestIndividual()
    if bestIndividual < bestOfGeneration {
        bestIndividual = bestOfGeneration
        viewController.updateBestRoute(distance: bestIndividual.fitness, route: bestIndividual.genotype)
    }
    
    viewController.updateGeneration(generation: generation)
}

geneticAlgorithmProxy.generateRandomPopulationBlock = generateRandomPopulation
geneticAlgorithmProxy.evolveBlock = evolve

PlaygroundPage.current.liveView = viewController
//#-end-hidden-code
