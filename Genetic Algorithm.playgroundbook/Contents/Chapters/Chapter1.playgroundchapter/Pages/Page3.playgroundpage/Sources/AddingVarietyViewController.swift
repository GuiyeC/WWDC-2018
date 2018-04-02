//
//  AddingVarietyViewController.swift
//  
//
//  Created by Guillermo Cique Fernández on 31/3/18.
//

import UIKit
import SpriteKit
import PlaygroundSupport

public class AddingVarietyViewController : UIViewController, PlaygroundLiveViewSafeAreaContainer {
    
    var parents: (Creature, Creature) = (randomCreature(), randomCreature())
    let crossoverBlock: (Creature, Creature) -> (Creature, Creature)
    let mutationBlock: (Creature) -> Creature
    let scene1: PopulationScene = PopulationScene(creatures: [])
    let scene2: PopulationScene = PopulationScene(creatures: [])
    
    public init(crossoverBlock: @escaping (Creature, Creature) -> (Creature, Creature), mutationBlock: @escaping (Creature) -> Creature) {
        self.crossoverBlock = crossoverBlock
        self.mutationBlock = mutationBlock
        
        scene1.creatures = [parents.0, parents.1]
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum ButtonTitles {
        static let mutateParents = NSLocalizedString("Mutate", comment: "Mutates parents")
    }
    
    enum LabelTitles {
        static let parents = NSLocalizedString("Parents", comment: "Describes the parent creatures")
        static let descendants = NSLocalizedString("Descendants", comment: "Describes the descendants of the parent creatures")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let parentsView = RoundedVisualEffectView()
        parentsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(parentsView)
        NSLayoutConstraint.activate([
            parentsView.topAnchor.constraint(equalTo: liveViewSafeAreaGuide.topAnchor, constant: 32),
            parentsView.leadingAnchor.constraint(greaterThanOrEqualTo: liveViewSafeAreaGuide.leadingAnchor, constant: 32),
            parentsView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
            ])
        
        let parentsLabel = UILabel()
        parentsLabel.translatesAutoresizingMaskIntoConstraints = false
        parentsLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        parentsLabel.textColor = .black
        parentsLabel.text = LabelTitles.parents
        view.addSubview(parentsLabel)
        NSLayoutConstraint.activate([
            parentsLabel.topAnchor.constraint(equalTo: parentsView.topAnchor, constant: 8),
            parentsLabel.leadingAnchor.constraint(equalTo: parentsView.leadingAnchor, constant: 16),
            parentsLabel.centerYAnchor.constraint(equalTo: parentsView.centerYAnchor, constant: 0)
            ])
        
        let mutateParentsButton = UIButton(type: .system)
        mutateParentsButton.translatesAutoresizingMaskIntoConstraints = false
        mutateParentsButton.setTitle(ButtonTitles.mutateParents, for: [])
        mutateParentsButton.addTarget(self, action: #selector(mutateParents), for: .touchUpInside)
        view.addSubview(mutateParentsButton)
        NSLayoutConstraint.activate([
            mutateParentsButton.topAnchor.constraint(equalTo: parentsView.topAnchor, constant: 8),
            mutateParentsButton.leadingAnchor.constraint(equalTo: parentsLabel.trailingAnchor, constant: 24),
            mutateParentsButton.trailingAnchor.constraint(equalTo: parentsView.trailingAnchor, constant: -16),
            mutateParentsButton.centerYAnchor.constraint(equalTo: parentsView.centerYAnchor, constant: 0)
            ])
        
        let skView1 = SKView()
        skView1.backgroundColor = .clear
        skView1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(skView1)
        NSLayoutConstraint.activate([
            skView1.topAnchor.constraint(equalTo: parentsView.bottomAnchor, constant: 16),
            skView1.leadingAnchor.constraint(equalTo: liveViewSafeAreaGuide.leadingAnchor, constant: 32),
            skView1.trailingAnchor.constraint(equalTo: liveViewSafeAreaGuide.trailingAnchor, constant: -32)
            ])
        
        scene1.backgroundColor = .clear
        scene1.scaleMode = .resizeFill
        skView1.preferredFramesPerSecond = 60
        skView1.presentScene(scene1)
        
        let descendantsView = RoundedVisualEffectView()
        descendantsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descendantsView)
        NSLayoutConstraint.activate([
            descendantsView.heightAnchor.constraint(equalTo: parentsView.heightAnchor, constant: 0),
            descendantsView.topAnchor.constraint(equalTo: skView1.bottomAnchor, constant: 16),
            descendantsView.leadingAnchor.constraint(greaterThanOrEqualTo: liveViewSafeAreaGuide.leadingAnchor, constant: 32),
            descendantsView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
            ])
        
        let descendantsLabel = UILabel()
        descendantsLabel.translatesAutoresizingMaskIntoConstraints = false
        descendantsLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        descendantsLabel.textColor = .black
        descendantsLabel.text = LabelTitles.descendants
        view.addSubview(descendantsLabel)
        NSLayoutConstraint.activate([
            descendantsLabel.topAnchor.constraint(equalTo: descendantsView.topAnchor, constant: 8),
            descendantsLabel.leadingAnchor.constraint(equalTo: descendantsView.leadingAnchor, constant: 16),
            descendantsLabel.centerYAnchor.constraint(equalTo: descendantsView.centerYAnchor, constant: 0),
            descendantsLabel.centerXAnchor.constraint(equalTo: descendantsView.centerXAnchor, constant: 0)
            ])
        
        let skView2 = SKView()
        skView2.backgroundColor = .clear
        skView2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(skView2)
        NSLayoutConstraint.activate([
            skView2.heightAnchor.constraint(equalTo: skView1.heightAnchor, constant: 0),
            skView2.topAnchor.constraint(equalTo: descendantsLabel.bottomAnchor, constant: 16),
            skView2.leadingAnchor.constraint(equalTo: liveViewSafeAreaGuide.leadingAnchor, constant: 32),
            skView2.trailingAnchor.constraint(equalTo: liveViewSafeAreaGuide.trailingAnchor, constant: -32),
            skView2.bottomAnchor.constraint(equalTo: liveViewSafeAreaGuide.bottomAnchor, constant: 0)
            ])
        
        scene2.backgroundColor = .clear
        scene2.scaleMode = .resizeFill
        skView2.preferredFramesPerSecond = 60
        skView2.presentScene(scene2)
        
        view.backgroundColor = .clear
        
        updateDescendants()
    }
    
    @objc func mutateParents() {
        parents = (mutationBlock(parents.0), mutationBlock(parents.1))
        scene1.creatures = [parents.0, parents.1]
        
        updateDescendants()
    }
    
    func updateDescendants() {
        let descendants = crossoverBlock(parents.0, parents.1)
        scene2.creatures = [descendants.0, descendants.1]
    }

}