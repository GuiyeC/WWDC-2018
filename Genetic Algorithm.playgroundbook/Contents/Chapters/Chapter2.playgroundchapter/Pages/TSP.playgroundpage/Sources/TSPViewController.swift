//
//  TSPViewController.swift
//
//
//  Created by Guillermo Cique Fernández on 31/3/18.
//

import UIKit
import SpriteKit
import PlaygroundSupport

public class TSPViewController: UIViewController, PlaygroundLiveViewSafeAreaContainer {
    
    enum ButtonTitles {
        static let start = NSLocalizedString("Start", comment:"Start running the genetic algorithm")
        static let pause = NSLocalizedString("Pause", comment:"Pause the genetic algorithm")
        static let reset = NSLocalizedString("Reset", comment: "Clear the cities")
    }
    
    enum LabelTitles {
        static let generation = NSLocalizedString("Generation", comment: "Title describing the current generation")
        static let bestDistance = NSLocalizedString("Best distance", comment: "Title describing the best distance")
    }
    
    public var geneticAlgorithmProxy: GeneticAlgorithmProxy!
    
    let scene = TSPScene()
    var startPauseButton: UIButton!
    var generationLabel: UILabel!
    var bestDistanceLabel: UILabel!
    let numberFormatter = NumberFormatter()
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        
        view.backgroundColor = .clear
        
        let skView = SKView()
        skView.backgroundColor = .clear
        skView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(skView)
        NSLayoutConstraint.activate([
            skView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            skView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            skView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            skView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
            ])
        
        scene.backgroundColor = .clear
        scene.scaleMode = .resizeFill
        skView.preferredFramesPerSecond = 60
        skView.presentScene(scene)
        
        let generationView = RoundedVisualEffectView()
        generationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(generationView)
        
        let generationTitleLabel = UILabel()
        generationTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        generationTitleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        generationTitleLabel.textColor = .black
        generationTitleLabel.text = LabelTitles.generation
        view.addSubview(generationTitleLabel)
        
        generationLabel = UILabel()
        generationLabel.isUserInteractionEnabled = false
        generationLabel.translatesAutoresizingMaskIntoConstraints = false
        generationLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        generationLabel.textColor = .black
        generationLabel.text = "0"
        view.addSubview(generationLabel)
        
        NSLayoutConstraint.activate([
            generationView.bottomAnchor.constraint(equalTo: liveViewSafeAreaGuide.bottomAnchor, constant: -16),
            generationView.leadingAnchor.constraint(equalTo: liveViewSafeAreaGuide.leadingAnchor, constant: 24),
            
            generationTitleLabel.topAnchor.constraint(equalTo: generationView.topAnchor, constant: 8),
            generationTitleLabel.leadingAnchor.constraint(equalTo: generationView.leadingAnchor, constant: 16),
            generationTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: generationView.trailingAnchor, constant: -16),
            
            generationLabel.topAnchor.constraint(equalTo: generationTitleLabel.bottomAnchor, constant: 8),
            generationLabel.leadingAnchor.constraint(equalTo: generationView.leadingAnchor, constant: 16),
            generationLabel.trailingAnchor.constraint(lessThanOrEqualTo: generationView.trailingAnchor, constant: -16),
            generationLabel.bottomAnchor.constraint(equalTo: generationView.bottomAnchor, constant: -8)
            ])
        
        
        let bestDistanceView = RoundedVisualEffectView()
        bestDistanceView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bestDistanceView)
        
        let bestDistanceTitleLabel = UILabel()
        bestDistanceTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        bestDistanceTitleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        bestDistanceTitleLabel.textColor = .black
        bestDistanceTitleLabel.text = LabelTitles.bestDistance
        view.addSubview(bestDistanceTitleLabel)
        
        bestDistanceLabel = UILabel()
        bestDistanceLabel.isUserInteractionEnabled = false
        bestDistanceLabel.translatesAutoresizingMaskIntoConstraints = false
        bestDistanceLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        bestDistanceLabel.textColor = .black
        bestDistanceLabel.text = "0 km"
        view.addSubview(bestDistanceLabel)
        
        NSLayoutConstraint.activate([
            bestDistanceView.bottomAnchor.constraint(equalTo: liveViewSafeAreaGuide.bottomAnchor, constant: -16),
            bestDistanceView.trailingAnchor.constraint(equalTo: liveViewSafeAreaGuide.trailingAnchor, constant: -24),
            
            bestDistanceTitleLabel.topAnchor.constraint(equalTo: bestDistanceView.topAnchor, constant: 8),
            bestDistanceTitleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: bestDistanceView.leadingAnchor, constant: 16),
            bestDistanceTitleLabel.trailingAnchor.constraint(equalTo: bestDistanceView.trailingAnchor, constant: -16),
            
            bestDistanceLabel.topAnchor.constraint(equalTo: bestDistanceTitleLabel.bottomAnchor, constant: 8),
            bestDistanceLabel.leadingAnchor.constraint(greaterThanOrEqualTo: bestDistanceView.leadingAnchor, constant: 16),
            bestDistanceLabel.trailingAnchor.constraint(equalTo: bestDistanceView.trailingAnchor, constant: -16),
            bestDistanceLabel.bottomAnchor.constraint(equalTo: bestDistanceView.bottomAnchor, constant: -8)
            ])
        
        
        let startPauseView = RoundedVisualEffectView()
        startPauseView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startPauseView)
        
        startPauseButton = UIButton(type: .system)
        startPauseButton.translatesAutoresizingMaskIntoConstraints = false
        startPauseButton.setTitle(ButtonTitles.start, for: [])
        startPauseButton.addTarget(self, action: #selector(startPauseGeneticAlgorithm), for: .touchUpInside)
        view.addSubview(startPauseButton)
        NSLayoutConstraint.activate([
            startPauseView.topAnchor.constraint(equalTo: liveViewSafeAreaGuide.topAnchor, constant: 24),
            startPauseView.leadingAnchor.constraint(equalTo: liveViewSafeAreaGuide.leadingAnchor, constant: 24),
            
            startPauseButton.topAnchor.constraint(equalTo: startPauseView.topAnchor, constant: 8),
            startPauseButton.leadingAnchor.constraint(equalTo: startPauseView.leadingAnchor, constant: 16),
            startPauseButton.centerXAnchor.constraint(equalTo: startPauseView.centerXAnchor, constant: 0),
            startPauseButton.centerYAnchor.constraint(equalTo: startPauseView.centerYAnchor, constant: 0)
            ])
        
        
        let resetView = RoundedVisualEffectView()
        resetView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resetView)
        
        let resetButton = UIButton(type: .system)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.setTitle(ButtonTitles.reset, for: [])
        resetButton.addTarget(self, action: #selector(reset), for: .touchUpInside)
        view.addSubview(resetButton)
        NSLayoutConstraint.activate([
            resetView.topAnchor.constraint(equalTo: liveViewSafeAreaGuide.topAnchor, constant: 24),
            resetView.trailingAnchor.constraint(equalTo: liveViewSafeAreaGuide.trailingAnchor, constant: -24),
            
            resetButton.topAnchor.constraint(equalTo: resetView.topAnchor, constant: 8),
            resetButton.leadingAnchor.constraint(equalTo: resetView.leadingAnchor, constant: 16),
            resetButton.centerXAnchor.constraint(equalTo: resetView.centerXAnchor, constant: 0),
            resetButton.centerYAnchor.constraint(equalTo: resetView.centerYAnchor, constant: 0)
            ])
        
    }
    
    public func updateGeneration(generation: Int) {
        DispatchQueue.main.async {
            guard self.geneticAlgorithmProxy.isInitialized else {
                return
            }
            
            self.generationLabel.text = "\(generation)"
        }
    }
    
    public func updateBestRoute(distance: Double, route: Route) {
        DispatchQueue.main.async {
            guard self.geneticAlgorithmProxy.isInitialized else {
                return
            }

            self.scene.drawBestRoute(route)

            let formattedDistance = self.numberFormatter.string(from: distance as NSNumber) ?? "0"
            self.bestDistanceLabel.text = "\(formattedDistance) km" // Or miles? ¯\_(ツ)_/¯
        }
    }
    
    @objc func startPauseGeneticAlgorithm() {
        if geneticAlgorithmProxy.isInitialized {
            if geneticAlgorithmProxy.isRunning {
                geneticAlgorithmProxy.pause()
                startPauseButton.setTitle(ButtonTitles.start, for: [])
            }
            else {
                geneticAlgorithmProxy.start()
                startPauseButton.setTitle(ButtonTitles.pause, for: [])
            }
        }
        else {
            let cities = scene.cities
            if geneticAlgorithmProxy.initialize(cities: cities) {
                scene.allowsToAddCities = false
                startPauseButton.setTitle(ButtonTitles.pause, for: [])
            }
        }
    }
    
    @objc func reset() {
        geneticAlgorithmProxy.stop()
        scene.clear()

        generationLabel.text = "0"
        bestDistanceLabel.text = "0 km"
        startPauseButton.setTitle(ButtonTitles.start, for: [])
    }
    
}
