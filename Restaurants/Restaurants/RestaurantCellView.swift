//
//  RestaurantCellView.swift
//  Restaurants
//
//  Created by Ted Zhang on 10/7/18.
//  Copyright © 2018 Ted Zhang. All rights reserved.
//

import UIKit
import SDWebImage

class RestaurantCell : UITableViewCell {
    
    let maxWidthConstraint:CGFloat      = 50
    let topConstraint:CGFloat           = 15
    let bottomConstraint:CGFloat        = -15
    let leftConstraint:CGFloat          = 10
    let rightConstraint:CGFloat         = -10
    let hgapConstraint:CGFloat          = 10
    let vgapConstraint:CGFloat          = 2
    let greaterHeightConstraint:CGFloat = 15
    let imageHeight:CGFloat             = 60
    let imageWidth:CGFloat              = 159
    
    //MARK:- Properties
    lazy var pictureImageView:UIImageView = {
        let imageView         = UIImageView(image: nil)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var nameLabel:UILabel = {
        let label = getLabel(numberOfLines: 0, weight:.bold)
        return label
    }()
    
    lazy var categoryLabel:UILabel = {
        let label = getLabel(numberOfLines: 0, textColor:UIColor(red:0.58, green:0.58, blue:0.58, alpha:1.00))
        return label
    }()
    
    lazy var deliveryLabel:UILabel = {
        let label = getLabel(textColor:UIColor(red:0.31, green:0.31, blue:0.31, alpha:1.00))
        return label
    }()
    
    lazy var distanceLabel:UILabel = {
        let label = getLabel(textColor:UIColor(red:0.31, green:0.31, blue:0.31, alpha:1.00))
        return label
    }()
    
    private func getLabel(numberOfLines:Int = 1, weight:UIFont.Weight = .regular, textColor:UIColor = UIColor.black, fontSize:CGFloat = UIFont.systemFontSize, accessibility:Bool = true) -> UILabel {
        let label                                       = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines                             = numberOfLines
        label.textColor                                 = textColor
        label.font                                      = UIFont.systemFont(ofSize: fontSize, weight: weight)
        label.isAccessibilityElement                    = accessibility

        // custome font with Accessibility Dynamic Type support
        /*
         label.font  = UIFontMetrics.scaledFont(<#CustomeFont#>)
         */

        return label
    }

    static let ReuseIdentifier:String   = {
        return String(describing: RestaurantCell.self)
    }()
    
    func driveUI(model:Restaurant){
        
        contentView.addSubview(pictureImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(deliveryLabel)
        contentView.addSubview(distanceLabel)
        
        createConstraints()
        
        if let imageUrlString = model.coverImgURL, let imageUrl = URL(string: imageUrlString) {
            pictureImageView.sd_setImage(with:imageUrl, completed: nil)
        }
        nameLabel.text = model.name
        categoryLabel.text = model.description
        #warning("hard code currency!")
        deliveryLabel.text = String(format: "$%d delivery fee", model.deliveryFee ?? 0)
        distanceLabel.text = String(format: "%d min", model.asapTime ?? 0)
        
    }
}

extension RestaurantCell {
    fileprivate func createConstraints(){
        NSLayoutConstraint.activate([
            pictureImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topConstraint),
            pictureImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: leftConstraint),
            pictureImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            pictureImageView.widthAnchor.constraint(equalTo: pictureImageView.heightAnchor, multiplier: imageWidth/imageHeight),

            nameLabel.topAnchor.constraint(equalTo: pictureImageView.topAnchor),
            nameLabel.leftAnchor.constraint(equalTo: pictureImageView.rightAnchor, constant: hgapConstraint),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: rightConstraint),

            categoryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: vgapConstraint),
            categoryLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            categoryLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: rightConstraint),

            deliveryLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: vgapConstraint),
            deliveryLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            deliveryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: bottomConstraint),

            distanceLabel.lastBaselineAnchor.constraint(equalTo: deliveryLabel.lastBaselineAnchor),
            distanceLabel.widthAnchor.constraint(lessThanOrEqualToConstant: maxWidthConstraint),
            distanceLabel.leftAnchor.constraint(equalTo: deliveryLabel.rightAnchor, constant: hgapConstraint),
            distanceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: rightConstraint)
        ])
    }
}
