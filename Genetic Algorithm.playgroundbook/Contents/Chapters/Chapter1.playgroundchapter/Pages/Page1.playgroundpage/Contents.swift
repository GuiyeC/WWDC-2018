//#-hidden-code
//
//  Contents.swift
//
//  Created by Guillermo Cique Fernández on 31/3/18.
//
//#-end-hidden-code
/*:
 # Genetic Algorithm
 Genetic Algorithms are search algorithms based on the principles of genetics and evolution. They can be really useful when trying to find or improve solutions to complex problems that cannot be tackled by traditional methods. But what does this mean? How can we replicate evolution? Let's go step by step.
 
 Let's take a group of possible solutions to a problem. We'll call each possible solution an **individual** and the whole group a **population**. We might not have that initial group of possible solutions so we might as well create a random population. You can tap on the live view on the right and start creating your on random population.
 
 
 Here is a simple implementation of an ```Individual```.
 
 Each **individual** has a **genotype** and a **fitness**.
 
 The **genotype** of an individual is what makes it itself, it's the way to obtaining a solution or **phenotype**. This genotype can be anything, from a string of bits to a complex tree.
 
 The **fitness** is how promising the solution looks, we'll see this more in depth in the next page. 
 */ 

protocol Individual: Comparable {
    associatedtype Genotype
    
    var genotype: Genotype { get set }
    var fitness: Double { get set }
    
    init(genotype: Genotype)
    
    func cross(with other: Self) -> (Self, Self)
    mutating func mutate(by mutationPercentage: Int)
    mutating func evaluate()
}

//#-hidden-code
//#-editable-code
//#-end-editable-code
//#-end-hidden-code
