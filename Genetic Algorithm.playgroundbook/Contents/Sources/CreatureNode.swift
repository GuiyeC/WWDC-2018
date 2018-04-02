//
//  CreatureNode.swift
//  
//
//  Created by Guillermo Cique Fernández on 31/3/18.
//

import SpriteKit

public class CreatureNode : SKSpriteNode {
    
    public var creature: Creature {
        didSet {
            paintCreature()
        }
    }
    
    public init(creature: Creature) {
        self.creature = creature
        super.init(texture: nil, color: .clear, size: CGSize(width: 100, height: 100))
        paintCreature()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func paintCreature() {
        removeAllChildren()
        
        paintBody()
        paintEyes()
        paintMouth()
    }
    
    func paintBody() {
        let path: CGPath
        
        switch creature.bodyType {
        case .triangle:
            path = triangleShapePath()
        case .circle:
            path = circleShapePath()
        case .square:
            path = squareShapePath()
        case .star:
            path = starShapePath()
        }
        
        let bodyNode = SKShapeNode(path: path, centered: true)
        bodyNode.fillColor = creature.color
        bodyNode.strokeColor = creature.borderColor
        bodyNode.lineWidth = creature.borderSize
        
        addChild(bodyNode)
        
        switch creature.bodyType {
        case .triangle, .square:
            let rotateAction1 = SKAction.rotate(byAngle: 0.3, duration: 1)
            let rotateAction2 = SKAction.rotate(byAngle: -0.6, duration: 2)
            let rotateAction3 = SKAction.rotate(byAngle: 0.3, duration: 1)
            let actions = SKAction.sequence([rotateAction1, rotateAction2, rotateAction3])
            let repeatRotation = SKAction.repeatForever(actions)
            
            bodyNode.run(repeatRotation)
        case .circle, .star:
            let rotateAction1 = SKAction.rotate(byAngle: CGFloat.pi * 2, duration: 10)
            let rotateAction2 = SKAction.rotate(byAngle: CGFloat.pi * -2, duration: 10)
            let actions = SKAction.sequence([rotateAction1, rotateAction2])
            let repeatRotation = SKAction.repeatForever(actions)
            
            bodyNode.run(repeatRotation)
        }
    }
    
    func paintEyes() {
        let eye1: SKShapeNode
        let eye2: SKShapeNode
        
        switch creature.eyeType {
        case .dot:
            eye1 = SKShapeNode(circleOfRadius: 4)
            eye1.fillColor = SKColor.black
            eye1.strokeColor = .clear
            
            eye2 = SKShapeNode(circleOfRadius: 4)
            eye2.fillColor = SKColor.black
            eye2.strokeColor = .clear
            break
        case .circle:
            eye1 = SKShapeNode(circleOfRadius: 8)
            eye1.fillColor = .black
            eye1.lineWidth = 3
            
            eye2 = SKShapeNode(circleOfRadius: 8)
            eye2.fillColor = .black
            eye2.lineWidth = 3
        case .triangle:
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 0.0, y: -8.0))
            path.addLine(to: CGPoint(x: 8.0, y: 8.0))
            path.addLine(to: CGPoint(x: -8.0, y: 8.0))
            path.close()
            
            eye1 = SKShapeNode()
            eye1.path = path.cgPath
            eye1.fillColor = .black
            eye1.lineWidth = 3
            
            eye2 = SKShapeNode()
            eye2.path = path.cgPath
            eye2.fillColor = .black
            eye2.lineWidth = 3
        case .square:
            eye1 = SKShapeNode(rectOf: CGSize(width: 16, height: 16))
            eye1.fillColor = .black
            eye1.lineWidth = 3
            
            eye2 = SKShapeNode(rectOf: CGSize(width: 16, height: 16))
            eye2.fillColor = .black
            eye2.lineWidth = 3
        }
        
        eye1.position = CGPoint(x: -30, y: 30)
        eye2.position = CGPoint(x: 30, y: 30)
        
        addChild(eye1)
        addChild(eye2)
    }
    
    func paintMouth() {
        let mouth: SKShapeNode
        switch creature.mouthType {
        case .mustache:
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 16.0, y: -16.0))
            path.addLine(to: CGPoint(x: -16.0, y: -16.0))
            path.addCurve(to: CGPoint(x: 16.0, y: -16.0), controlPoint1: CGPoint(x: 10.0, y: 0.0), controlPoint2: CGPoint(x: -10.0, y: 0.0))
            path.close()
            
            mouth = SKShapeNode()
            mouth.path = path.cgPath
        case .line:
            mouth = SKShapeNode(rectOf: CGSize(width: 30, height: 4))
        case .happy:
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 12.0, y: 12.0))
            path.addLine(to: CGPoint(x: -12.0, y: 12.0))
            path.addCurve(to: CGPoint(x: 12.0, y: 12.0), controlPoint1: CGPoint(x: -10.0, y: -8.0), controlPoint2: CGPoint(x: 10.0, y: -8.0))
            path.close()
            
            mouth = SKShapeNode()
            mouth.path = path.cgPath
        case .surprised:
            mouth = SKShapeNode(circleOfRadius: 13)
        }
        
        mouth.strokeColor = .clear
        mouth.fillColor = .black
        mouth.position = CGPoint(x: 0, y: 0)
        
        addChild(mouth)
    }
    
    public func mutate(by mutationPercentage: Int) {
        creature.mutate(by: mutationPercentage)
    }
    
    func triangleShapePath() -> CGPath {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 55.5, y: 140.5))
        bezierPath.addCurve(to: CGPoint(x: 58.5, y: 132.5), controlPoint1: CGPoint(x: 55.5, y: 140.5), controlPoint2: CGPoint(x: 57.75, y: 134.5))
        bezierPath.addCurve(to: CGPoint(x: 65.5, y: 124.5), controlPoint1: CGPoint(x: 59.25, y: 130.5), controlPoint2: CGPoint(x: 63.75, y: 126.5))
        bezierPath.addCurve(to: CGPoint(x: 65.5, y: 117.5), controlPoint1: CGPoint(x: 67.25, y: 122.5), controlPoint2: CGPoint(x: 65.5, y: 119.25))
        bezierPath.addCurve(to: CGPoint(x: 72.5, y: 108.5), controlPoint1: CGPoint(x: 65.5, y: 115.75), controlPoint2: CGPoint(x: 70.75, y: 110.75))
        bezierPath.addCurve(to: CGPoint(x: 75.5, y: 97.5), controlPoint1: CGPoint(x: 74.25, y: 106.25), controlPoint2: CGPoint(x: 74.75, y: 100.25))
        bezierPath.addCurve(to: CGPoint(x: 82.5, y: 88.5), controlPoint1: CGPoint(x: 76.25, y: 94.75), controlPoint2: CGPoint(x: 80.75, y: 90.75))
        bezierPath.addCurve(to: CGPoint(x: 86.5, y: 74.5), controlPoint1: CGPoint(x: 84.25, y: 86.25), controlPoint2: CGPoint(x: 85.5, y: 78))
        bezierPath.addCurve(to: CGPoint(x: 92.5, y: 65.5), controlPoint1: CGPoint(x: 87.5, y: 71), controlPoint2: CGPoint(x: 91, y: 67.75))
        bezierPath.addCurve(to: CGPoint(x: 96.5, y: 53.5), controlPoint1: CGPoint(x: 94, y: 63.25), controlPoint2: CGPoint(x: 95.5, y: 56.5))
        bezierPath.addCurve(to: CGPoint(x: 104.5, y: 41.5), controlPoint1: CGPoint(x: 97.5, y: 50.5), controlPoint2: CGPoint(x: 102.5, y: 44.5))
        bezierPath.addCurve(to: CGPoint(x: 110.5, y: 56.5), controlPoint1: CGPoint(x: 106.5, y: 38.5), controlPoint2: CGPoint(x: 109, y: 52.75))
        bezierPath.addCurve(to: CGPoint(x: 117.5, y: 65.5), controlPoint1: CGPoint(x: 112, y: 60.25), controlPoint2: CGPoint(x: 115.75, y: 63.25))
        bezierPath.addCurve(to: CGPoint(x: 121.5, y: 77.5), controlPoint1: CGPoint(x: 119.25, y: 67.75), controlPoint2: CGPoint(x: 120.5, y: 74.5))
        bezierPath.addCurve(to: CGPoint(x: 129.5, y: 88.5), controlPoint1: CGPoint(x: 122.5, y: 80.5), controlPoint2: CGPoint(x: 127.5, y: 85.75))
        bezierPath.addCurve(to: CGPoint(x: 133.5, y: 102.5), controlPoint1: CGPoint(x: 131.5, y: 91.25), controlPoint2: CGPoint(x: 132.5, y: 99))
        bezierPath.addCurve(to: CGPoint(x: 138.5, y: 108.5), controlPoint1: CGPoint(x: 134.5, y: 106), controlPoint2: CGPoint(x: 137.25, y: 107))
        bezierPath.addCurve(to: CGPoint(x: 141.5, y: 117.5), controlPoint1: CGPoint(x: 139.75, y: 110), controlPoint2: CGPoint(x: 140.75, y: 115.25))
        bezierPath.addCurve(to: CGPoint(x: 147.5, y: 124.5), controlPoint1: CGPoint(x: 142.25, y: 119.75), controlPoint2: CGPoint(x: 146, y: 122.75))
        bezierPath.addCurve(to: CGPoint(x: 147.5, y: 132.5), controlPoint1: CGPoint(x: 149, y: 126.25), controlPoint2: CGPoint(x: 147.5, y: 130.5))
        bezierPath.addCurve(to: CGPoint(x: 152.5, y: 136.5), controlPoint1: CGPoint(x: 147.5, y: 134.5), controlPoint2: CGPoint(x: 152.5, y: 136.5))
        bezierPath.addCurve(to: CGPoint(x: 152.5, y: 140.5), controlPoint1: CGPoint(x: 152.5, y: 136.5), controlPoint2: CGPoint(x: 152.5, y: 139.5))
        bezierPath.addCurve(to: CGPoint(x: 141.5, y: 140.5), controlPoint1: CGPoint(x: 152.5, y: 141.5), controlPoint2: CGPoint(x: 141.5, y: 140.5))
        bezierPath.addCurve(to: CGPoint(x: 129.5, y: 140.5), controlPoint1: CGPoint(x: 141.5, y: 140.5), controlPoint2: CGPoint(x: 132.5, y: 140.5))
        bezierPath.addCurve(to: CGPoint(x: 117.5, y: 143.5), controlPoint1: CGPoint(x: 126.5, y: 140.5), controlPoint2: CGPoint(x: 120.5, y: 142.75))
        bezierPath.addCurve(to: CGPoint(x: 107.5, y: 140.5), controlPoint1: CGPoint(x: 114.5, y: 144.25), controlPoint2: CGPoint(x: 107.5, y: 140.5))
        bezierPath.addCurve(to: CGPoint(x: 92.5, y: 143.5), controlPoint1: CGPoint(x: 107.5, y: 140.5), controlPoint2: CGPoint(x: 96.25, y: 142.75))
        bezierPath.addCurve(to: CGPoint(x: 79.5, y: 140.5), controlPoint1: CGPoint(x: 88.75, y: 144.25), controlPoint2: CGPoint(x: 82.75, y: 141.25))
        bezierPath.addCurve(to: CGPoint(x: 72.5, y: 143.5), controlPoint1: CGPoint(x: 76.25, y: 139.75), controlPoint2: CGPoint(x: 74.25, y: 142.75))
        bezierPath.addCurve(to: CGPoint(x: 55.5, y: 140.5), controlPoint1: CGPoint(x: 70.75, y: 144.25), controlPoint2: CGPoint(x: 55.5, y: 140.5))
        bezierPath.close()
        
        return bezierPath.cgPath
    }
    
    func starShapePath() -> CGPath {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 17.97, y: 11.5))
        bezierPath.addCurve(to: CGPoint(x: 39.21, y: 22.78), controlPoint1: CGPoint(x: 17.97, y: 11.5), controlPoint2: CGPoint(x: 33.9, y: 19.96))
        bezierPath.addCurve(to: CGPoint(x: 49.27, y: 1.35), controlPoint1: CGPoint(x: 44.52, y: 25.6), controlPoint2: CGPoint(x: 46.75, y: 6.71))
        bezierPath.addCurve(to: CGPoint(x: 60.44, y: 22.78), controlPoint1: CGPoint(x: 51.78, y: -4), controlPoint2: CGPoint(x: 57.65, y: 17.42))
        bezierPath.addCurve(to: CGPoint(x: 81.68, y: 11.5), controlPoint1: CGPoint(x: 63.24, y: 28.14), controlPoint2: CGPoint(x: 76.37, y: 14.32))
        bezierPath.addCurve(to: CGPoint(x: 76.09, y: 35.19), controlPoint1: CGPoint(x: 86.99, y: 8.68), controlPoint2: CGPoint(x: 77.49, y: 29.27))
        bezierPath.addCurve(to: CGPoint(x: 98.44, y: 43.08), controlPoint1: CGPoint(x: 74.69, y: 41.11), controlPoint2: CGPoint(x: 92.85, y: 41.11))
        bezierPath.addCurve(to: CGPoint(x: 81.68, y: 56.61), controlPoint1: CGPoint(x: 104.03, y: 45.05), controlPoint2: CGPoint(x: 85.87, y: 53.23))
        bezierPath.addCurve(to: CGPoint(x: 93.97, y: 76.92), controlPoint1: CGPoint(x: 77.49, y: 60), controlPoint2: CGPoint(x: 90.9, y: 71.84))
        bezierPath.addCurve(to: CGPoint(x: 69.38, y: 76.92), controlPoint1: CGPoint(x: 97.04, y: 81.99), controlPoint2: CGPoint(x: 75.53, y: 76.92))
        bezierPath.addCurve(to: CGPoint(x: 69.38, y: 99.47), controlPoint1: CGPoint(x: 63.24, y: 76.92), controlPoint2: CGPoint(x: 69.38, y: 93.83))
        bezierPath.addCurve(to: CGPoint(x: 49.27, y: 81.43), controlPoint1: CGPoint(x: 69.38, y: 105.11), controlPoint2: CGPoint(x: 54.3, y: 85.94))
        bezierPath.addCurve(to: CGPoint(x: 32.5, y: 99.47), controlPoint1: CGPoint(x: 44.24, y: 76.92), controlPoint2: CGPoint(x: 36.69, y: 94.96))
        bezierPath.addCurve(to: CGPoint(x: 32.5, y: 76.92), controlPoint1: CGPoint(x: 28.31, y: 103.98), controlPoint2: CGPoint(x: 32.5, y: 82.55))
        bezierPath.addCurve(to: CGPoint(x: 6.8, y: 76.92), controlPoint1: CGPoint(x: 32.5, y: 71.28), controlPoint2: CGPoint(x: 13.22, y: 76.92))
        bezierPath.addCurve(to: CGPoint(x: 17.97, y: 56.61), controlPoint1: CGPoint(x: 0.37, y: 76.92), controlPoint2: CGPoint(x: 15.18, y: 61.69))
        bezierPath.addCurve(to: CGPoint(x: 0.09, y: 43.08), controlPoint1: CGPoint(x: 20.77, y: 51.54), controlPoint2: CGPoint(x: 4.56, y: 46.46))
        bezierPath.addCurve(to: CGPoint(x: 23.56, y: 35.19), controlPoint1: CGPoint(x: -4.38, y: 39.7), controlPoint2: CGPoint(x: 17.7, y: 37.16))
        bezierPath.addCurve(to: CGPoint(x: 17.97, y: 11.5), controlPoint1: CGPoint(x: 29.43, y: 33.21), controlPoint2: CGPoint(x: 17.97, y: 11.5))
        bezierPath.close()
        
        return bezierPath.cgPath
    }
    
    func squareShapePath() -> CGPath {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 11.53, y: 9.27))
        bezierPath.addCurve(to: CGPoint(x: 22.05, y: 5.64), controlPoint1: CGPoint(x: 11.53, y: 9.27), controlPoint2: CGPoint(x: 19.42, y: 6.55))
        bezierPath.addCurve(to: CGPoint(x: 37.35, y: 9.27), controlPoint1: CGPoint(x: 24.68, y: 4.74), controlPoint2: CGPoint(x: 33.53, y: 8.36))
        bezierPath.addCurve(to: CGPoint(x: 48.83, y: 5.64), controlPoint1: CGPoint(x: 41.18, y: 10.18), controlPoint2: CGPoint(x: 45.96, y: 6.55))
        bezierPath.addCurve(to: CGPoint(x: 63.17, y: 9.27), controlPoint1: CGPoint(x: 51.7, y: 4.74), controlPoint2: CGPoint(x: 59.59, y: 8.36))
        bezierPath.addCurve(to: CGPoint(x: 74.65, y: 5.64), controlPoint1: CGPoint(x: 66.76, y: 10.18), controlPoint2: CGPoint(x: 71.78, y: 6.55))
        bezierPath.addCurve(to: CGPoint(x: 85.17, y: 9.27), controlPoint1: CGPoint(x: 77.52, y: 4.74), controlPoint2: CGPoint(x: 82.54, y: 8.36))
        bezierPath.addCurve(to: CGPoint(x: 93.78, y: 5.64), controlPoint1: CGPoint(x: 87.8, y: 10.18), controlPoint2: CGPoint(x: 91.62, y: 6.55))
        bezierPath.addCurve(to: CGPoint(x: 101.43, y: 9.27), controlPoint1: CGPoint(x: 95.93, y: 4.74), controlPoint2: CGPoint(x: 99.51, y: 8.36))
        bezierPath.addCurve(to: CGPoint(x: 107.16, y: 12.9), controlPoint1: CGPoint(x: 103.34, y: 10.18), controlPoint2: CGPoint(x: 105.73, y: 11.99))
        bezierPath.addCurve(to: CGPoint(x: 104.3, y: 20.15), controlPoint1: CGPoint(x: 108.6, y: 13.8), controlPoint2: CGPoint(x: 105.01, y: 18.33))
        bezierPath.addCurve(to: CGPoint(x: 107.16, y: 26.49), controlPoint1: CGPoint(x: 103.58, y: 21.96), controlPoint2: CGPoint(x: 106.45, y: 24.91))
        bezierPath.addCurve(to: CGPoint(x: 104.3, y: 34.65), controlPoint1: CGPoint(x: 107.88, y: 28.08), controlPoint2: CGPoint(x: 105.01, y: 32.61))
        bezierPath.addCurve(to: CGPoint(x: 107.16, y: 40.09), controlPoint1: CGPoint(x: 103.58, y: 36.69), controlPoint2: CGPoint(x: 106.45, y: 38.73))
        bezierPath.addCurve(to: CGPoint(x: 104.3, y: 46.44), controlPoint1: CGPoint(x: 107.88, y: 41.45), controlPoint2: CGPoint(x: 105.01, y: 44.85))
        bezierPath.addCurve(to: CGPoint(x: 107.16, y: 51.87), controlPoint1: CGPoint(x: 103.58, y: 48.02), controlPoint2: CGPoint(x: 106.45, y: 50.51))
        bezierPath.addCurve(to: CGPoint(x: 104.3, y: 57.31), controlPoint1: CGPoint(x: 107.88, y: 53.23), controlPoint2: CGPoint(x: 105.01, y: 55.95))
        bezierPath.addCurve(to: CGPoint(x: 107.16, y: 64.56), controlPoint1: CGPoint(x: 103.58, y: 58.67), controlPoint2: CGPoint(x: 106.45, y: 62.75))
        bezierPath.addCurve(to: CGPoint(x: 104.3, y: 68.19), controlPoint1: CGPoint(x: 107.88, y: 66.38), controlPoint2: CGPoint(x: 104.3, y: 68.19))
        bezierPath.addCurve(to: CGPoint(x: 107.16, y: 76.35), controlPoint1: CGPoint(x: 104.3, y: 68.19), controlPoint2: CGPoint(x: 106.45, y: 74.31))
        bezierPath.addCurve(to: CGPoint(x: 104.3, y: 81.79), controlPoint1: CGPoint(x: 107.88, y: 78.39), controlPoint2: CGPoint(x: 104.3, y: 81.79))
        bezierPath.addCurve(to: CGPoint(x: 107.16, y: 87.23), controlPoint1: CGPoint(x: 104.3, y: 81.79), controlPoint2: CGPoint(x: 106.45, y: 85.87))
        bezierPath.addCurve(to: CGPoint(x: 104.3, y: 91.76), controlPoint1: CGPoint(x: 107.88, y: 88.59), controlPoint2: CGPoint(x: 105.01, y: 90.63))
        bezierPath.addCurve(to: CGPoint(x: 107.16, y: 97.2), controlPoint1: CGPoint(x: 103.58, y: 92.89), controlPoint2: CGPoint(x: 106.45, y: 95.84))
        bezierPath.addCurve(to: CGPoint(x: 104.3, y: 101.73), controlPoint1: CGPoint(x: 107.88, y: 98.56), controlPoint2: CGPoint(x: 105.01, y: 100.6))
        bezierPath.addCurve(to: CGPoint(x: 101.43, y: 105.36), controlPoint1: CGPoint(x: 103.58, y: 102.86), controlPoint2: CGPoint(x: 102.14, y: 104.45))
        bezierPath.addCurve(to: CGPoint(x: 93.78, y: 101.73), controlPoint1: CGPoint(x: 100.71, y: 106.26), controlPoint2: CGPoint(x: 93.78, y: 101.73))
        bezierPath.addCurve(to: CGPoint(x: 89.95, y: 105.36), controlPoint1: CGPoint(x: 93.78, y: 101.73), controlPoint2: CGPoint(x: 90.91, y: 104.45))
        bezierPath.addCurve(to: CGPoint(x: 85.17, y: 101.73), controlPoint1: CGPoint(x: 88.99, y: 106.26), controlPoint2: CGPoint(x: 86.36, y: 102.64))
        bezierPath.addCurve(to: CGPoint(x: 77.52, y: 105.36), controlPoint1: CGPoint(x: 83.97, y: 100.82), controlPoint2: CGPoint(x: 79.43, y: 104.45))
        bezierPath.addCurve(to: CGPoint(x: 70.82, y: 101.73), controlPoint1: CGPoint(x: 75.61, y: 106.26), controlPoint2: CGPoint(x: 70.82, y: 101.73))
        bezierPath.addCurve(to: CGPoint(x: 66.04, y: 105.36), controlPoint1: CGPoint(x: 70.82, y: 101.73), controlPoint2: CGPoint(x: 67.24, y: 104.45))
        bezierPath.addCurve(to: CGPoint(x: 58.39, y: 101.73), controlPoint1: CGPoint(x: 64.85, y: 106.26), controlPoint2: CGPoint(x: 60.3, y: 102.64))
        bezierPath.addCurve(to: CGPoint(x: 54.57, y: 105.36), controlPoint1: CGPoint(x: 56.48, y: 100.82), controlPoint2: CGPoint(x: 55.52, y: 104.45))
        bezierPath.addCurve(to: CGPoint(x: 48.83, y: 101.73), controlPoint1: CGPoint(x: 53.61, y: 106.26), controlPoint2: CGPoint(x: 50.26, y: 102.64))
        bezierPath.addCurve(to: CGPoint(x: 40.22, y: 105.36), controlPoint1: CGPoint(x: 47.39, y: 100.82), controlPoint2: CGPoint(x: 42.37, y: 104.45))
        bezierPath.addCurve(to: CGPoint(x: 33.53, y: 101.73), controlPoint1: CGPoint(x: 38.07, y: 106.26), controlPoint2: CGPoint(x: 33.53, y: 101.73))
        bezierPath.addCurve(to: CGPoint(x: 28.75, y: 105.36), controlPoint1: CGPoint(x: 33.53, y: 101.73), controlPoint2: CGPoint(x: 29.94, y: 104.45))
        bezierPath.addCurve(to: CGPoint(x: 22.05, y: 101.73), controlPoint1: CGPoint(x: 27.55, y: 106.26), controlPoint2: CGPoint(x: 22.05, y: 101.73))
        bezierPath.addCurve(to: CGPoint(x: 16.31, y: 105.36), controlPoint1: CGPoint(x: 22.05, y: 101.73), controlPoint2: CGPoint(x: 17.75, y: 104.45))
        bezierPath.addCurve(to: CGPoint(x: 11.53, y: 101.73), controlPoint1: CGPoint(x: 14.88, y: 106.26), controlPoint2: CGPoint(x: 12.73, y: 102.64))
        bezierPath.addCurve(to: CGPoint(x: 6.75, y: 105.36), controlPoint1: CGPoint(x: 10.34, y: 100.82), controlPoint2: CGPoint(x: 6.75, y: 105.36))
        bezierPath.addCurve(to: CGPoint(x: 2.93, y: 101.73), controlPoint1: CGPoint(x: 6.75, y: 105.36), controlPoint2: CGPoint(x: 3.88, y: 102.64))
        bezierPath.addCurve(to: CGPoint(x: 6.75, y: 97.2), controlPoint1: CGPoint(x: 1.97, y: 100.82), controlPoint2: CGPoint(x: 5.79, y: 98.33))
        bezierPath.addCurve(to: CGPoint(x: 2.93, y: 91.76), controlPoint1: CGPoint(x: 7.71, y: 96.06), controlPoint2: CGPoint(x: 2.93, y: 91.76))
        bezierPath.addCurve(to: CGPoint(x: 6.75, y: 87.23), controlPoint1: CGPoint(x: 2.93, y: 91.76), controlPoint2: CGPoint(x: 5.79, y: 88.36))
        bezierPath.addCurve(to: CGPoint(x: 2.93, y: 81.79), controlPoint1: CGPoint(x: 7.71, y: 86.09), controlPoint2: CGPoint(x: 3.88, y: 83.15))
        bezierPath.addCurve(to: CGPoint(x: 6.75, y: 76.35), controlPoint1: CGPoint(x: 1.97, y: 80.43), controlPoint2: CGPoint(x: 5.79, y: 77.71))
        bezierPath.addCurve(to: CGPoint(x: 2.93, y: 71.82), controlPoint1: CGPoint(x: 7.71, y: 74.99), controlPoint2: CGPoint(x: 3.88, y: 72.95))
        bezierPath.addCurve(to: CGPoint(x: 6.75, y: 68.19), controlPoint1: CGPoint(x: 1.97, y: 70.68), controlPoint2: CGPoint(x: 5.79, y: 69.1))
        bezierPath.addCurve(to: CGPoint(x: 2.93, y: 60.94), controlPoint1: CGPoint(x: 7.71, y: 67.28), controlPoint2: CGPoint(x: 3.88, y: 62.75))
        bezierPath.addCurve(to: CGPoint(x: 6.75, y: 57.31), controlPoint1: CGPoint(x: 1.97, y: 59.13), controlPoint2: CGPoint(x: 5.79, y: 58.22))
        bezierPath.addCurve(to: CGPoint(x: 2.93, y: 51.87), controlPoint1: CGPoint(x: 7.71, y: 56.41), controlPoint2: CGPoint(x: 3.88, y: 53.23))
        bezierPath.addCurve(to: CGPoint(x: 6.75, y: 46.44), controlPoint1: CGPoint(x: 1.97, y: 50.51), controlPoint2: CGPoint(x: 5.79, y: 47.8))
        bezierPath.addCurve(to: CGPoint(x: 2.93, y: 40.09), controlPoint1: CGPoint(x: 7.71, y: 45.08), controlPoint2: CGPoint(x: 3.88, y: 41.68))
        bezierPath.addCurve(to: CGPoint(x: 6.75, y: 34.65), controlPoint1: CGPoint(x: 1.97, y: 38.5), controlPoint2: CGPoint(x: 5.79, y: 36.01))
        bezierPath.addCurve(to: CGPoint(x: 2.93, y: 26.49), controlPoint1: CGPoint(x: 7.71, y: 33.29), controlPoint2: CGPoint(x: 3.88, y: 28.53))
        bezierPath.addCurve(to: CGPoint(x: 6.75, y: 20.15), controlPoint1: CGPoint(x: 1.97, y: 24.45), controlPoint2: CGPoint(x: 5.79, y: 21.73))
        bezierPath.addCurve(to: CGPoint(x: 2.93, y: 15.62), controlPoint1: CGPoint(x: 7.71, y: 18.56), controlPoint2: CGPoint(x: 3.88, y: 16.75))
        bezierPath.addCurve(to: CGPoint(x: 2.93, y: 9.27), controlPoint1: CGPoint(x: 1.97, y: 14.48), controlPoint2: CGPoint(x: 2.93, y: 10.86))
        bezierPath.addCurve(to: CGPoint(x: 2.93, y: 9.27), controlPoint1: CGPoint(x: 2.93, y: 7.68), controlPoint2: CGPoint(x: 2.93, y: 9.27))
        bezierPath.addCurve(to: CGPoint(x: 6.75, y: 5.64), controlPoint1: CGPoint(x: 2.93, y: 9.27), controlPoint2: CGPoint(x: 5.79, y: 6.55))
        bezierPath.addCurve(to: CGPoint(x: 11.53, y: 9.27), controlPoint1: CGPoint(x: 7.71, y: 4.74), controlPoint2: CGPoint(x: 10.34, y: 8.36))
        bezierPath.close()
        
        return bezierPath.cgPath
    }
    
    func circleShapePath() -> CGPath {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 31.47, y: 7.61))
        bezierPath.addCurve(to: CGPoint(x: 46.91, y: 1.84), controlPoint1: CGPoint(x: 31.47, y: 7.61), controlPoint2: CGPoint(x: 43.05, y: 3.28))
        bezierPath.addCurve(to: CGPoint(x: 71.99, y: 4.72), controlPoint1: CGPoint(x: 50.77, y: 0.39), controlPoint2: CGPoint(x: 65.72, y: 4))
        bezierPath.addCurve(to: CGPoint(x: 87.42, y: 15.31), controlPoint1: CGPoint(x: 78.26, y: 5.45), controlPoint2: CGPoint(x: 83.56, y: 12.66))
        bezierPath.addCurve(to: CGPoint(x: 97.07, y: 28.78), controlPoint1: CGPoint(x: 91.28, y: 17.96), controlPoint2: CGPoint(x: 94.66, y: 25.42))
        bezierPath.addCurve(to: CGPoint(x: 102.86, y: 38.41), controlPoint1: CGPoint(x: 99.48, y: 32.15), controlPoint2: CGPoint(x: 101.41, y: 36))
        bezierPath.addCurve(to: CGPoint(x: 102.86, y: 53.81), controlPoint1: CGPoint(x: 104.3, y: 40.82), controlPoint2: CGPoint(x: 102.86, y: 49.96))
        bezierPath.addCurve(to: CGPoint(x: 97.07, y: 70.17), controlPoint1: CGPoint(x: 102.86, y: 57.66), controlPoint2: CGPoint(x: 98.52, y: 66.08))
        bezierPath.addCurve(to: CGPoint(x: 87.42, y: 84.6), controlPoint1: CGPoint(x: 95.62, y: 74.26), controlPoint2: CGPoint(x: 89.83, y: 81))
        bezierPath.addCurve(to: CGPoint(x: 83.56, y: 91.34), controlPoint1: CGPoint(x: 85.01, y: 88.21), controlPoint2: CGPoint(x: 84.53, y: 89.66))
        bezierPath.addCurve(to: CGPoint(x: 71.99, y: 96.15), controlPoint1: CGPoint(x: 82.6, y: 93.03), controlPoint2: CGPoint(x: 74.88, y: 94.95))
        bezierPath.addCurve(to: CGPoint(x: 59.45, y: 100.97), controlPoint1: CGPoint(x: 69.09, y: 97.36), controlPoint2: CGPoint(x: 62.58, y: 99.76))
        bezierPath.addCurve(to: CGPoint(x: 43.05, y: 100.97), controlPoint1: CGPoint(x: 56.31, y: 102.17), controlPoint2: CGPoint(x: 47.15, y: 100.97))
        bezierPath.addCurve(to: CGPoint(x: 31.47, y: 96.15), controlPoint1: CGPoint(x: 38.95, y: 100.97), controlPoint2: CGPoint(x: 34.37, y: 97.36))
        bezierPath.addCurve(to: CGPoint(x: 19.9, y: 91.34), controlPoint1: CGPoint(x: 28.58, y: 94.95), controlPoint2: CGPoint(x: 22.79, y: 92.54))
        bezierPath.addCurve(to: CGPoint(x: 13.15, y: 81.72), controlPoint1: CGPoint(x: 17, y: 90.14), controlPoint2: CGPoint(x: 14.83, y: 84.12))
        bezierPath.addCurve(to: CGPoint(x: 4.46, y: 70.17), controlPoint1: CGPoint(x: 11.46, y: 79.31), controlPoint2: CGPoint(x: 6.64, y: 73.06))
        bezierPath.addCurve(to: CGPoint(x: 4.46, y: 50.92), controlPoint1: CGPoint(x: 2.29, y: 67.28), controlPoint2: CGPoint(x: 4.46, y: 55.73))
        bezierPath.addCurve(to: CGPoint(x: 4.46, y: 34.56), controlPoint1: CGPoint(x: 4.46, y: 46.11), controlPoint2: CGPoint(x: 4.46, y: 38.65))
        bezierPath.addCurve(to: CGPoint(x: 10.25, y: 20.12), controlPoint1: CGPoint(x: 4.46, y: 30.47), controlPoint2: CGPoint(x: 8.81, y: 23.73))
        bezierPath.addCurve(to: CGPoint(x: 31.47, y: 7.61), controlPoint1: CGPoint(x: 11.7, y: 16.51), controlPoint2: CGPoint(x: 31.47, y: 7.61))
        bezierPath.close()
        
        return bezierPath.cgPath
    }
    
}
