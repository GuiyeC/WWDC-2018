//
//  SelectionViewController.swift
//  
//
//  Created by Guillermo Cique Fernández on 31/3/18.
//

import UIKit
import SpriteKit
import PlaygroundSupport

public class SelectionViewController : UIViewController, PlaygroundLiveViewSafeAreaContainer {

    let scene1: PopulationScene
    let scene2: PopulationScene
    
    public init(population1: [Creature], population2: [Creature]) {
        scene1 = PopulationScene(creatures: population1)
        scene2 = PopulationScene(creatures: population2)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum LabelTitles {
        static let randomPopulation = NSLocalizedString("Random population", comment: "Describes the population generated randomly")
        static let selectedPopulation = NSLocalizedString("Selected population", comment: "Describes the population selected")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        let randomPopulationView = RoundedVisualEffectView()
        randomPopulationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(randomPopulationView)
        NSLayoutConstraint.activate([
            randomPopulationView.topAnchor.constraint(equalTo: liveViewSafeAreaGuide.topAnchor, constant: 32),
            randomPopulationView.leadingAnchor.constraint(greaterThanOrEqualTo: liveViewSafeAreaGuide.leadingAnchor, constant: 32),
            randomPopulationView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
            ])

        let randomPopulationLabel = UILabel()
        randomPopulationLabel.translatesAutoresizingMaskIntoConstraints = false
        randomPopulationLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        randomPopulationLabel.textColor = .black
        randomPopulationLabel.text = LabelTitles.randomPopulation
        view.addSubview(randomPopulationLabel)
        NSLayoutConstraint.activate([
            randomPopulationLabel.topAnchor.constraint(equalTo: randomPopulationView.topAnchor, constant: 8),
            randomPopulationLabel.leadingAnchor.constraint(equalTo: randomPopulationView.leadingAnchor, constant: 16),
            randomPopulationLabel.centerYAnchor.constraint(equalTo: randomPopulationView.centerYAnchor, constant: 0),
            randomPopulationLabel.centerXAnchor.constraint(equalTo: randomPopulationView.centerXAnchor, constant: 0)
            ])
        
        let skView1 = SKView()
        skView1.backgroundColor = .clear
        skView1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(skView1)
        NSLayoutConstraint.activate([
            skView1.topAnchor.constraint(equalTo: randomPopulationLabel.bottomAnchor, constant: 16),
            skView1.leadingAnchor.constraint(equalTo: liveViewSafeAreaGuide.leadingAnchor, constant: 32),
            skView1.trailingAnchor.constraint(equalTo: liveViewSafeAreaGuide.trailingAnchor, constant: -32)
            ])
        
        scene1.backgroundColor = .clear
        scene1.scaleMode = .resizeFill
        skView1.preferredFramesPerSecond = 60
        skView1.presentScene(scene1)

        
        let selectedPopulationView = RoundedVisualEffectView()
        selectedPopulationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(selectedPopulationView)
        NSLayoutConstraint.activate([
            selectedPopulationView.heightAnchor.constraint(equalTo: randomPopulationView.heightAnchor, constant: 0),
            selectedPopulationView.topAnchor.constraint(equalTo: skView1.bottomAnchor, constant: 16),
            selectedPopulationView.leadingAnchor.constraint(greaterThanOrEqualTo: liveViewSafeAreaGuide.leadingAnchor, constant: 32),
            selectedPopulationView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
            ])
        
        let selectedPopulationLabel = UILabel()
        selectedPopulationLabel.translatesAutoresizingMaskIntoConstraints = false
        selectedPopulationLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        selectedPopulationLabel.textColor = .black
        selectedPopulationLabel.text = LabelTitles.selectedPopulation
        view.addSubview(selectedPopulationLabel)
        NSLayoutConstraint.activate([
            selectedPopulationLabel.topAnchor.constraint(equalTo: selectedPopulationView.topAnchor, constant: 8),
            selectedPopulationLabel.leadingAnchor.constraint(equalTo: selectedPopulationView.leadingAnchor, constant: 16),
            selectedPopulationLabel.centerYAnchor.constraint(equalTo: selectedPopulationView.centerYAnchor, constant: 0),
            selectedPopulationLabel.centerXAnchor.constraint(equalTo: selectedPopulationView.centerXAnchor, constant: 0)
            ])
        
        let skView2 = SKView()
        skView2.backgroundColor = .clear
        skView2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(skView2)
        NSLayoutConstraint.activate([
            skView2.heightAnchor.constraint(equalTo: skView1.heightAnchor, constant: 0),
            skView2.topAnchor.constraint(equalTo: selectedPopulationLabel.bottomAnchor, constant: 16),
            skView2.leadingAnchor.constraint(equalTo: liveViewSafeAreaGuide.leadingAnchor, constant: 32),
            skView2.trailingAnchor.constraint(equalTo: liveViewSafeAreaGuide.trailingAnchor, constant: -32),
            skView2.bottomAnchor.constraint(equalTo: liveViewSafeAreaGuide.bottomAnchor, constant: 0)
            ])
        
        scene2.backgroundColor = .clear
        scene2.scaleMode = .resizeFill
        skView2.preferredFramesPerSecond = 60
        skView2.presentScene(scene2)
        
        view.backgroundColor = .clear
    }

}