//
//  SaveLocalProject.swift
//  PhoToMaker
//
//  Created by Huy Spring on 12/04/2022.
//

import Foundation
import UIKit

extension EditViewController{
    
    func saveTempl(){
        local.append(LocalData(id: 1, templ: listView))
//        localSave()
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: local)
        INIT_USER_DEFAULTS.set(encodedData, forKey: "currentProject")
        INIT_USER_DEFAULTS.synchronize()
//        CURRENT_PROJECT.set
    }
    
    func localSave(){
        
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: local)
        INIT_USER_DEFAULTS.set(encodedData, forKey: "local")
        INIT_USER_DEFAULTS.synchronize()
        
    }
    func loadProject(project: LocalData){
//        let itemView = ItemContainerView()
//        itemView.frame.size = CGSize(width: imageview.frame.width * hesonhan, height: imageview.frame.height * hesonhan)
//        itemView.contentView = imageview
//        itemView.delegate = self
//        containerView.addSubview(itemView)
//        itemView.center = containerViewImageBG.center
//        itemView.hideAccesories(completion: nil)
//        addGestures(view: itemView)
//        self.listView.append(itemView)
//        undoManager?.registerUndo(withTarget: self, handler: { (targetSelf) in
//            targetSelf.deleteButtonTapped(item: itemView)
//        })
//        
//        loadItemView()
//        handleShowLayer()
    }
}
