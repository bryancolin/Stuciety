//
//  QuestionnaireCollectionViewCell.swift
//  Stuciety
//
//  Created by bryan colin on 4/22/21.
//

import UIKit
import RandomColorSwift

class QuestionnaireCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var completion: UIImageView!
    @IBOutlet weak var view: UIView!
    
    let gradientLayer = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.lastLineFillPercent = 50
        titleLabel.linesCornerRadius = 5
        completion.skeletonCornerRadius = Float(completion.frame.width/2)
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: self.layer)
        
        gradientLayer.frame = view.bounds
    }
    
    func configure(name: String, complete: Bool) {
        titleLabel.text = name
        completion.isHidden = !complete
        
        // Gradient Layer
        gradientLayer.colors = [
            randomColor(hue: .random, luminosity: .light).cgColor,
            randomColor(hue: .random, luminosity: .light).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0,y: 0)
        gradientLayer.endPoint = CGPoint(x: 1,y: 1)
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}



