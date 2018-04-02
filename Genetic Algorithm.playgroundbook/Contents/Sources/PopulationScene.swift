//
//  PopulationScene.swift
//  
//
//  Created by Guillermo Cique Fernández on 31/3/18.
//

import SpriteKit

public class PopulationScene : SKScene {
    
    public var creatures: [Creature] = [] {
        didSet {
            setupCreatures()
        }
    }
    
    public init(creatures: [Creature]) {
        super.init()
        
        self.creatures = creatures
    }
    
    override public init(size: CGSize) {
        super.init(size: size)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder:coder)
    }
    
    
    override public func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        
        setupCreatures()
    }
    
    override public func didMove(to view: SKView) {
        setupCreatures()
    }
    
    func setupCreatures() {
        removeAllChildren()
        
        if size.width / size.height > 2 || creatures.count <= 3 {
            let y = size.height / 2
            let xGap = size.width / CGFloat(creatures.count)
            var x = xGap / 2
            let scale = min(1, x / 50)
            
            for creature in creatures {
                let creatureNode = CreatureNode(creature: creature)
                creatureNode.position = CGPoint(x: x, y: y)
                creatureNode.xScale = scale
                creatureNode.yScale = scale
                addChild(creatureNode)
                
                x += xGap
            }
        }
        else {
            let y1 = size.height / 4
            let y2 = size.height / 2 + y1
            let xGap = size.width / CGFloat((creatures.count+1) / 2)
            var x = xGap / 2
            let scale = min(1, x / 50)
            
            for (creature1, creature2) in zip(creatures, creatures.dropFirst((creatures.count+1) / 2)) {
                let creatureNode1 = CreatureNode(creature: creature1)
                creatureNode1.position = CGPoint(x: x, y: y1)
                creatureNode1.xScale = scale
                creatureNode1.yScale = scale
                addChild(creatureNode1)
                let creatureNode2 = CreatureNode(creature: creature2)
                creatureNode2.position = CGPoint(x: x, y: y2)
                creatureNode2.xScale = scale
                creatureNode2.yScale = scale
                addChild(creatureNode2)
                
                x += xGap
            }
        }
    }
    
}