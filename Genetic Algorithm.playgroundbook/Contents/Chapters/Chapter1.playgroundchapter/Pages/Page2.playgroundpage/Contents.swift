//#-hidden-code
//
//  Contents.swift
//
//  Created by Guillermo Cique Fernández on 31/3/18.
//
//#-end-hidden-code
/*:
 A population has many different potential solutions and we really need to evaluate how good they actually are, how "fit" they are. This is the process of **evaluation**, it's one of the most important parts of a genetic algorithm.
 
 When evaluating an individual we need to set its **fitness**, this **fitness** will be very important very soon.
 
 You can edit this evaluation function to look for other traits, right now we are looking for the luckiest creature but we could look for the most intelligent or the strongest one, you can combine this however you want.
 */ 

//#-editable-code
func evaluate(individual: Creature) -> Double {
    return individual.luck
}
//#-end-editable-code

/*: 
 Once we've evaluated every individual comes the fun part. As with evolution we will select a new population, favoring those individuals that look more promising, this is why a good evaluation is so important...
 
 There are many selection algorithms, here we have **Tournament Selection**. Tournament Selection consists on picking random individuals and selecting the best one between them. This favors the fittest but doesn't completely rule out the rest, we all like an underdog.
 
 Play around with this algorithm, once you are happy with the result you can run your code and see how the selected population is more populated by the fittest ones.
*/

//#-editable-code
func select(population: [Creature]) -> [Creature] {
    var selectedPopulation: [Creature] = []
    
    for _ in 0..<population.count {
        let individual1 = population.randomItem()
        let individual2 = population.randomItem()
        
        let best = max(individual1, individual2)
        selectedPopulation.append(best)
    }
    
    return selectedPopulation
}
//#-end-editable-code

var population = generateRandomPopulation(of: 10)
population.evaluate(evaluate)
var selectedPopulation = select(population: population)

//#-hidden-code
import PlaygroundSupport

let viewController = SelectionViewController(population1: population, population2: selectedPopulation)
PlaygroundPage.current.liveView = viewController
//#-end-hidden-code
