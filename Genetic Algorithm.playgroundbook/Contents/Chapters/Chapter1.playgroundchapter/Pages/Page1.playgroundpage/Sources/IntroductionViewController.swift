//
//  IntroductionViewController.swift
//  
//
//  Created by Guillermo Cique Fernández on 31/3/18.
//

import UIKit
import SpriteKit
import PlaygroundSupport

public class IntroductionViewController : UIViewController, PlaygroundLiveViewSafeAreaContainer {

    enum LabelTitles {
        static let title = NSLocalizedString("Population", comment: "Title describing the LiveView")
        static let help = NSLocalizedString("Tap to add random individuals", comment: "Text to help the user interact with the view")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let helpLabel = UILabel()
        helpLabel.translatesAutoresizingMaskIntoConstraints = false
        helpLabel.font = UIFont.preferredFont(forTextStyle: .body)
        helpLabel.textAlignment = .center
        helpLabel.textColor = .darkGray
        helpLabel.text = LabelTitles.help
        view.addSubview(helpLabel)
        NSLayoutConstraint.activate([
            helpLabel.leadingAnchor.constraint(greaterThanOrEqualTo: liveViewSafeAreaGuide.leadingAnchor, constant: 32),
            helpLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            helpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
            ])
        
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
    
        let scene = IntroductionScene()
        scene.backgroundColor = .clear
        scene.scaleMode = .resizeFill
        skView.preferredFramesPerSecond = 60
        skView.presentScene(scene)
                
        let titleView = RoundedVisualEffectView()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleView)
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: liveViewSafeAreaGuide.topAnchor, constant: 32),
            titleView.leadingAnchor.constraint(greaterThanOrEqualTo: liveViewSafeAreaGuide.leadingAnchor, constant: 32),
            titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
            ])

        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.textColor = .black
        titleLabel.text = LabelTitles.title
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor, constant: 0),
            titleLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor, constant: 0)
            ])
        
        view.backgroundColor = .clear
    }

}