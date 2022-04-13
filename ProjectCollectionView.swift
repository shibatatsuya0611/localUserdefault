//
//  ProjectCollectionView.swift
//  PhoToMaker
//
//  Created by Admin on 3/10/22.
//

import UIKit

class ProjectCollectionView: UICollectionView {

    let cellID = "cellCollection"
    let data = loadPeople()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout)
    {
        super.init(frame: frame, collectionViewLayout: layout)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(hex: "F9F9FF")
        allowsMultipleSelection = false
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        keyboardDismissMode = .onDrag
        
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate func setupCollectionView()
    {
        self.fillSuperview()
        
        //collectionView settings
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        
        self.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        self.setContentOffset(CGPoint.zero, animated: true)
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionViewFlowLayout.minimumLineSpacing = 10
        collectionViewFlowLayout.minimumInteritemSpacing = 10
         
         
        self.delegate = self
        self.dataSource = self
        self.register(ProjectCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
    }

}
extension ProjectCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ProjectCollectionViewCell
        
//        cell.delegate = self
//        cell.lblNumberOder.text = "\(indexPath.row + 1)"
//        if data.count > 0
//        {
//            cell.data = data[indexPath.item]
//            self.oderId = cell.oderId!
//        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width: CGFloat = self.frame.width / 2.1
        let height: CGFloat = self.frame.width / 1.9
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if indexPath.item == data.count - 1
//        {
//            self.delegateListOder?._CollectionViewDelegateScrollBottom()
//        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = EditViewController()
        data?.forEach({ result in
            print("result: \(result.templ)")
            vc.listView = result.templ
        })
        vc.loadItemView()
        self.parentViewController?.navigationController?.pushViewController(vc, animated: true)
//        vc.hidesBottomBarWhenPushed = true
        
    }
}
class ProjectCollectionViewCell: baseCell {
    
    let imageCell: UIImageView =
    {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = #imageLiteral(resourceName: "PhotoRoom_20220307_111935")
        img.clipsToBounds = true
        img.layer.cornerRadius = 5
        img.backgroundColor = .gray
        
        return img
    }()
    let lblName: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Project so 1"
        lbl.font = UIFont(name: "Roboto-Light", size: fontSize13)
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    override func setupView() {
        super.setupView()
        setUpLayout()
    }
    func setUpLayout(){
        addSubview(imageCell)
        addSubview(lblName)
        imageCell.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .zero,size: .init(width: self.frame.width, height: self.frame.width))
        lblName.anchor(top: imageCell.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: 0))
    }
}
