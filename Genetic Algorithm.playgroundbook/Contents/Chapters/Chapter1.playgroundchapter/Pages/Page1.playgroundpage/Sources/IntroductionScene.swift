//
//  IntroductionScene.swift
//  
//
//  Created by Guillermo Cique Fernández on 31/3/18.
//

import SpriteKit

class IntroductionScene : SKScene {

    override init() {
        super.init()
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
    }
    
    func addCreature(at location: CGPoint) {
        let creature = randomCreature()
        let creatureNode = CreatureNode(creature: creature)
        creatureNode.position = location
        
        addChild(creatureNode)
        
        if children.count > 50 {
            children.first?.removeFromParent()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        for touch in touches {
            let location = touch.location(in: self)
            
            addCreature(at: location)
        }
    }
    
}