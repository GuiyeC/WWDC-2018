//
//  TSPScene.swift
//
//
//  Created by Guillermo Cique Fernández on 31/3/18.
//

import UIKit
import SpriteKit

class TSPScene : SKScene {
    
    private let cityEmoji = ["🌇", "🏢", "🌃", "🏠", "🏬", "🏩", "🏜", "🎢", "🏛", "🏟", "🎡", "🏰", "🏘", "🏦", "🏪", "🏡", "🏨", "🏫", "🏙", "🕍", "🏣", "💒", "🏯", "🏕", "🏥", "⛩", "🕌", "🏔", "🗽", "🗼", "🌉", "🏚", "🕋", "⛲️", "⛪️", "🏖", "🏭", "🏝", "🌃", "🏠", "🏬", "🏤", "🌆"]
    private var cityNodes: [SKNode] = []
    private var bestRouteNodes: [SKNode]?
    var cities: [City] = []
    var allowsToAddCities = true
    
    override init() {
        super.init()
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
    }
    
    func clear() {
        removeAllChildren()
        
        cities.removeAll()
        cityNodes.removeAll()
        bestRouteNodes?.removeAll()

        allowsToAddCities = true
    }
    
    func addCity(at location: CGPoint) {
        let emoji = cityEmoji[cityNodes.count % cityEmoji.count]
        
        let node = SKLabelNode(text: emoji)
        node.fontSize = 35
        node.verticalAlignmentMode = .center
        node.horizontalAlignmentMode = .center
        node.position = location
        addChild(node)
        
        cities.append(location)
        cityNodes.append(node)
    }
    
    func drawBestRoute(_ route: [CGPoint]) {
        bestRouteNodes?.forEach { $0.removeFromParent() }
        
        guard let firstCity = route.first else { return }
        let otherCities = route.dropFirst()
        
        let path = UIBezierPath()
        path.move(to: firstCity)
        otherCities.forEach { (city) in
            path.addLine(to: city)
        }
        path.addLine(to: firstCity)
        path.stroke()
        
        let streetShapeNode = SKShapeNode(path: path.cgPath)
        streetShapeNode.strokeColor = .black
        streetShapeNode.lineWidth = 10
        streetShapeNode.zPosition = -2
        addChild(streetShapeNode)
        
        let pattern : [CGFloat] = [5, 6]
        let dashed = path.cgPath.copy(dashingWithPhase: 0, lengths: pattern)
        let dashedShapeNode = SKShapeNode(path: dashed)
        dashedShapeNode.strokeColor = UIColor.white
        dashedShapeNode.lineWidth = 2
        dashedShapeNode.zPosition = -1
        addChild(dashedShapeNode)
        
        bestRouteNodes = [streetShapeNode, dashedShapeNode]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        guard allowsToAddCities else {
            return
        }
        
        for touch in touches {
            let location = touch.location(in: self)
            addCity(at: location)
        }
    }
    
}



