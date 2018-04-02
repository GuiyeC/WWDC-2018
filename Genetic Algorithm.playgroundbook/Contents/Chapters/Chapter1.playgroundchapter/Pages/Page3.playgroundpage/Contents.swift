//#-hidden-code
//
//  Contents.swift
//
//  Created by Guillermo Cique Fernández on 31/3/18.
//
//#-end-hidden-code
/*:
 You might have notice already that only with selection we would improve the overall population but we would never go pass the best solution from the initial population.

 As we said Genetic Algorithms are base on genetics and evolution, it's time to get freaky!

 We are going cross inviduals hoping to obtain the best traits from each parent.

 Our ```Creature``` genotype is an string of bits, if you feel adventurous you might have fun diggin in the code of how it's implemented 😉
 
 For our crossover algorithm we're randomly picking a cross point and taking half of the genotype of each parent. Can you think of a better crossing algorithm? Maybe we can have multiple cross points.
 */ 

//#-editable-code
func cross(_ data1: BitData, with data2: BitData, crossPoint: Int) -> BitData {
    let newData = data1[0..<crossPoint] | data2[crossPoint..<data2.count]
    return newData
}
//#-end-editable-code

func cross(_ creature1: Creature, with creature2: Creature) -> (Creature, Creature) {
//#-editable-code
    let genotypeSize = creature1.genotype.count
    let crossPoint = random(to: genotypeSize)
    
    let newData1 = cross(creature1.genotype, with: creature2.genotype, crossPoint: crossPoint)
    let newData2 = cross(creature2.genotype, with: creature1.genotype, crossPoint: crossPoint)
    
    let descendant1 = Creature(genotype: newData1)
    let descendant2 = Creature(genotype: newData2)
    
    return (descendant1, descendant2)
//#-end-editable-code
}

/*:
 Once crossover is done we will mutate the population to add variety and diversity to the new **generation**.

 We don't want to get crazy with the ```mutationPercentage```, mutation is useful to add variety and prevent the population to become copies of the same individual, but we don't want to throw away the hard work of our fittest individuals by completly changing them.

 For now you can play around this value as much as you want.

 Feel free to modify the mutation function.
 */ 

// Between 0-100 😄
let mutationPercentage: Int = /*#-editable-code*/<#T##3##Int#>/*#-end-editable-code*/
func mutate(individual: Creature) -> Creature {
//#-editable-code
    var mutated = Creature(genotype: individual.genotype)
    
    for index in 0..<individual.genotype.count {
        if Bool(probability: mutationPercentage) {
            mutated.genotype.flip(at: index)
        }
    }
    
    return mutated
//#-end-editable-code
}

//#-hidden-code
import PlaygroundSupport

let viewController = AddingVarietyViewController(crossoverBlock: cross, mutationBlock: mutate)
PlaygroundPage.current.liveView = viewController
//#-end-hidden-code
