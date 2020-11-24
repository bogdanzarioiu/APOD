//
//  ExplanationView.swift
//  APOD
//
//  Created by Bogdan on 11/24/20.
//  Copyright © 2020 Bogdan Zarioiu. All rights reserved.
//

import Foundation
import UIKit


protocol SecretInstructionsDelegate {
    func handleDismissal()
    
}


class ExplanationView: UIView {
    
    var delegate: SecretInstructionsDelegate?
    
        var instructionsLabel: UILabel = {
        var instructions = UILabel()
        instructions.translatesAutoresizingMaskIntoConstraints = false
        instructions.textColor = .black
        instructions.font = UIFont(name: "AvenirNext-Heavy", size: 15)
        instructions.numberOfLines = 0
        instructions.text = ""
            instructions.textAlignment = .center
            
        
        return instructions
    }()
    
    private var dismissButton: UIButton = {
        var button = UIButton()
        button.setTitle("OK", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont(name: "AvenirNext-Heavy", size: 12)
        button.layer.cornerRadius = 5
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(handleDismiss(_:)), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear.withAlphaComponent(0.0)
        
        addSubview(instructionsLabel)
        instructionsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 100).isActive = true
        instructionsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        instructionsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        addSubview(dismissButton)
        dismissButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        dismissButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        dismissButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true

        dismissButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    @objc private func handleDismiss(_ sender: UIButton) {
        delegate?.handleDismissal()
        
    }
}
