//
//  ViewController.swift
//  APOD
//
//  Created by Bogdan on 10/16/20.
//  Copyright © 2020 Bogdan Zarioiu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var popUpInstructionsWindow: ExplanationView = {
        let popUpWindow = ExplanationView()
        popUpWindow.delegate = self
        popUpWindow.instructionsLabel.text = imageExplanation
        popUpWindow.translatesAutoresizingMaskIntoConstraints = false
        popUpWindow.layer.cornerRadius = 5
        
        return popUpWindow
    }()
    
    private var loadingLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading astronomy picture of the day..."
        label.font = UIFont(name: "AvenirNext-Heavy", size: 14)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        return label
    }()
    
    var spinner = UIActivityIndicatorView()
    
    var imageExplanation: String = ""
    
    private var astronomyImageOfDay: UIImageView!
    private var getImageButton = UIButton()
    private var descriptionLabel = UILabel()
    
    private var explanationView = UIView()
        
    var networkManager = NetworkManager()
    private let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        view.alpha = 0
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(spinner)
        spinner.color = .systemRed
        spinner.style = .medium
        spinner.startAnimating()
        
        spinner.translatesAutoresizingMaskIntoConstraints = false


        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        
        setupLoadingLabel()
        networkManager.getImageOfTheDay {[weak self] (model, image) in
            self?.imageExplanation = model.explanation
            DispatchQueue.main.async {
                self?.astronomyImageOfDay.image = image
                self?.spinner.stopAnimating()
                self?.spinner.hidesWhenStopped = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                    UIView.animate(withDuration: 0.2) {
                        self?.getImageButton.alpha = 1.0
                        self?.getImageButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                    }
                }
     
            }
        }
        
        setupAstronomyImage()
        setupDescriptionLabel()
        setupGetImageButton()
        //setupExplanationView()
        
        view.addSubview(visualEffectView)
        
        
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        
        
    }
    
    private func setupLoadingLabel() {
        view.addSubview(loadingLabel)
        
        loadingLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        loadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    
    
    
    
    @objc private func handleSecretInstructions(_ sender: UIButton) {
        view.addSubview(popUpInstructionsWindow)
        popUpInstructionsWindow.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popUpInstructionsWindow.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        popUpInstructionsWindow.widthAnchor.constraint(equalToConstant: 320).isActive = true
        popUpInstructionsWindow.heightAnchor.constraint(equalToConstant: 800).isActive = true
        
        popUpInstructionsWindow.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        popUpInstructionsWindow.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.alpha = 1
            self.popUpInstructionsWindow.alpha = 1
            self.popUpInstructionsWindow.transform = CGAffineTransform.identity
        }
        
        
        
    }
    
    
    
    
    private func setupAstronomyImage() {
        astronomyImageOfDay = UIImageView()
        view.addSubview(astronomyImageOfDay)
        astronomyImageOfDay.contentMode = .scaleAspectFill
        
        astronomyImageOfDay.translatesAutoresizingMaskIntoConstraints = false
        astronomyImageOfDay.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        astronomyImageOfDay.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        astronomyImageOfDay.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        astronomyImageOfDay.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        astronomyImageOfDay.isUserInteractionEnabled = true
        let touchGesture = UITapGestureRecognizer(target: self, action: #selector(handleTouch(_:)))
        touchGesture.numberOfTouchesRequired = 1
        touchGesture.numberOfTapsRequired = 1

        astronomyImageOfDay.addGestureRecognizer(touchGesture)
        
        
    }
    
    @objc private func handleTouch(_ gesture: UITapGestureRecognizer) {
        print("CALLED")
        if explanationView.alpha == 1 {
            explanationView.alpha = 0
        } else {
            explanationView.alpha = 1
        }


    }
    
    func setupDescriptionLabel() {
        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: astronomyImageOfDay.bottomAnchor, constant: 20).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        descriptionLabel.numberOfLines = 0
        
    }
    
    private func setupGetImageButton() {
        astronomyImageOfDay.addSubview(getImageButton)
        getImageButton.translatesAutoresizingMaskIntoConstraints = false

        getImageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        getImageButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200).isActive = true
        
        getImageButton.setTitle("i", for: .normal)
        getImageButton.setTitleColor(.white, for: .normal)
        getImageButton.backgroundColor = UIColor.clear.withAlphaComponent(0.3)
        
       
        getImageButton.titleLabel?.font = UIFont(name: "Avenir-Light", size: 12)
        getImageButton.alpha = 0.0


        
        getImageButton.addTarget(self, action: #selector(handleSecretInstructions(_:)), for: .touchUpInside)
    }
    
    
    @objc private func handleData(_ sender: UIButton) {
        networkManager.getImageOfTheDay {[weak self] (model, image) in
            print(model.explanation)
            DispatchQueue.main.async {
                self?.astronomyImageOfDay.image = image
                
            }
        }
        
    }
    
    private func setupExplanationView() {
        astronomyImageOfDay.addSubview(explanationView)
        explanationView.translatesAutoresizingMaskIntoConstraints = false

        explanationView.bottomAnchor.constraint(equalTo: astronomyImageOfDay.bottomAnchor).isActive = true
        explanationView.trailingAnchor.constraint(equalTo: astronomyImageOfDay.trailingAnchor).isActive = true

        explanationView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        explanationView.widthAnchor.constraint(equalToConstant: 50).isActive = true

        explanationView.backgroundColor = .clear
    }
    
    
    
    
    
    
}




extension ViewController: SecretInstructionsDelegate {
    func handleDismissal() {
        UIView.animate(withDuration: 0.3, animations: {
            self.visualEffectView.alpha = 0
            self.popUpInstructionsWindow.alpha = 0
            self.popUpInstructionsWindow.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.popUpInstructionsWindow.removeFromSuperview()
        }
    }
    
    
}

