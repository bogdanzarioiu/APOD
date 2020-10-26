//
//  ViewController.swift
//  APOD
//
//  Created by Bogdan on 10/16/20.
//  Copyright © 2020 Bogdan Zarioiu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var astronomyImageOfDay: UIImageView!
    private var getImageButton = UIButton()
    private var descriptionLabel = UILabel()
    
    private var explanationView = UIView()
    
    //private var loadingView = UIActivityIndicatorView()
    
    var networkManager = NetworkManager()
        
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //networkManager.delegate = self
        
//        view.addSubview(loadingView)
//        loadingView.center = view.center
        
        setupAstronomyImage()
        setupDescriptionLabel()
        setupGetImageButton()
        setupExplanationView()
    }
    
    private func setupAstronomyImage() {
        astronomyImageOfDay = UIImageView()
        astronomyImageOfDay.image = UIImage(systemName: "checkmark")
        view.addSubview(astronomyImageOfDay)
        astronomyImageOfDay.contentMode = .scaleAspectFill
        
        astronomyImageOfDay.translatesAutoresizingMaskIntoConstraints = false
        astronomyImageOfDay.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        astronomyImageOfDay.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        astronomyImageOfDay.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        astronomyImageOfDay.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.75).isActive = true
        
        
        astronomyImageOfDay.isUserInteractionEnabled = true
        let touchGesture = UITapGestureRecognizer(target: self, action: #selector(handleTouch(_:)))
        touchGesture.numberOfTouchesRequired = 1
        touchGesture.numberOfTapsRequired = 1
        
        astronomyImageOfDay.addGestureRecognizer(touchGesture)
        
        
    }
    
    @ objc private func handleTouch(_ gesture: UITapGestureRecognizer) {
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
        view.addSubview(getImageButton)
        getImageButton.translatesAutoresizingMaskIntoConstraints = false
        getImageButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        getImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        getImageButton.setTitle("Get data", for: .normal)
        getImageButton.backgroundColor = .black
        getImageButton.tintColor = .white
        
        getImageButton.addTarget(self, action: #selector(handleData(_:)), for: .touchUpInside)
    }

    
    @objc private func handleData(_ sender: UIButton) {
        //loadingView.startAnimating()
        print("pressed")

        networkManager.getImageOfTheDay { (model, image) in
            print(model.explanation)
            DispatchQueue.main.async {
                self.astronomyImageOfDay.image = image

            }
        }
//        networkManager.getImageOfTheDay {[weak self] (model, image) in
//            guard let self = self else { return }
//            print(model.explanation)
//        }
    }
    
    private func setupExplanationView() {
        astronomyImageOfDay.addSubview(explanationView)
        explanationView.translatesAutoresizingMaskIntoConstraints = false
        
        explanationView.bottomAnchor.constraint(equalTo: astronomyImageOfDay.bottomAnchor).isActive = true
        explanationView.trailingAnchor.constraint(equalTo: astronomyImageOfDay.trailingAnchor).isActive = true
        
        explanationView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        explanationView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        explanationView.backgroundColor = .systemGreen
    }
       
        
        
        //to add a checkmark image when data is downloaded fine
        
    

}


//extension ViewController: NetworkManagerDelegate {
//    func didFinishDownloadingDataFor(model: ImageOfTheDayModel) {
//        print(model.explanation)
//        DispatchQueue.main.async {
//            self.descriptionLabel.text = model.explanation
//
//        }
//
//    }
//
//}

