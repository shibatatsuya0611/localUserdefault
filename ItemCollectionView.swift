//
//  ItemCollectionView.swift
//  PhoToMaker
//
//  Created by Admin on 1/10/22.
//

import UIKit

protocol ItemCollectionViewDelegate : class {
    func _didSelectItem(item: ItemContainerView)
}
class ItemCollectionView: UICollectionView {

    let cellID = "cellCollection"
    var data: [ItemContainerView] = []
    weak var delegateprotocol: ItemCollectionViewDelegate?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout)
    {
        super.init(frame: frame, collectionViewLayout: layout)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = bgListHistoryOrder
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
        self.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
    }

}
extension ItemCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ItemCollectionViewCell
        
//        cell.delegate = self
//        cell.lblNumberOder.text = "\(indexPath.row + 1)"
        if data.count > 0
        {
            cell.data = data[indexPath.item]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width: CGFloat = self.frame.width
        let height: CGFloat = 60
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if indexPath.item == data.count - 1
//        {
//            self.delegateListOder?._CollectionViewDelegateScrollBottom()
//        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select")
        self.delegateprotocol?._didSelectItem(item: data[indexPath.row])
    }
}
