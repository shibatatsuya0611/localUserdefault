//
//  MenuControlCollectionViewCell.swift
//  PhoToMaker
//
//  Created by Admin on 1/10/22.
//

import UIKit
class ItemCollectionViewCell:baseCell{
    
    
    var imageCell: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear

        return v
    }()
    var imageCellInfor: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        v.image = UIImage(named: "layer-edit")
        
        return v
    }()
    let lblTitle: UILabel =
    {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Title"
        lbl.textColor = .black
        lbl.font = UIFont(name: "Roboto-Bold", size: fontSize18)
        lbl.textAlignment = .left
        return lbl
    }()
    override func setupView() {
        super.setupView()
        
        setupUI()
        makeBottomShadow(shadowOpacity: 1.0, shadowRadius: 1.0, radius: 5)
    }
    func setupUI(){
        addSubview(imageCell)
        addSubview(lblTitle)
        addSubview(imageCellInfor)
        
        imageCell.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .zero,size: .init(width: 50, height: 50))
        imageCell.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        lblTitle.leadingAnchor.constraint(equalTo: imageCell.trailingAnchor, constant: 20).isActive = true
        lblTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        imageCellInfor.anchor(top: nil, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 10), size: .init(width: 15, height: 15))
        imageCellInfor.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    var data: ItemContainerView!{
        didSet{
            
            if(data.contentView is UITextView){
                let tv = data.contentView as! UITextView
                lblTitle.text = tv.text
                imageCell.image = #imageLiteral(resourceName: "Asset_32")
            } else if(data.contentView is UIImageView){
                let imgv = data.contentView as! UIImageView
//                let imgv = data.contentImage!
                imageCell.image = imgv.image
                lblTitle.text = "Hình ảnh"
            }
        }
    }
}
