//
//  EditView_Control.swift
//  PhoToMaker
//
//  Created by Admin on 1/10/22.
//

import UIKit
import CoreMedia
extension EditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func addText(_ text: String){
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 20)
        textView.textColor = .black
        textView.layer.backgroundColor = UIColor.clear.cgColor
        textView.isUserInteractionEnabled = false
        let itemView = ItemContainerView()
        itemView.contentView = textView
        textEndEditing(textView, text)
        self.containerView.addSubview(itemView)
        itemView.center = containerViewImageBG.center
        itemView.delegate = self
        addGestures(view: itemView)
        activeItemView?.hideAccesories()
        self.listView.append(itemView)
        undoManager?.registerUndo(withTarget: self, handler: { (targetSelf) in
            targetSelf.deleteButtonTapped(item: itemView)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.activeItemView = itemView
        }
        
        loadItemView()
        handleShowLayer()
            
    }
    func textEndEditing(_ textView: UITextView, _ text: String?) {
        lastTextViewTransform = textView.superview?.transform
        textView.superview?.transform = .identity
        textView.text = text
//        textView.font = UIFont.systemFont(ofSize: 20)
//        textView.textColor = .black
        let sizeToFit = textView.sizeThatFits(CGSize(width: containerView.frame.width, height:CGFloat.greatestFiniteMagnitude))
        textView.superview?.frame.size = CGSize(width: sizeToFit.width, height: sizeToFit.height)
        textView.superview?.transform = lastTextViewTransform ?? .identity
        
    }
    func textEndEditingDuplicate(_ textView: UITextView, _ text: String?) {
        lastTextViewTransform = textView.superview?.transform
        let sizeToFit = textView.sizeThatFits(CGSize(width: containerView.frame.width, height:CGFloat.greatestFiniteMagnitude))
        textView.superview?.frame.size = CGSize(width: sizeToFit.width, height: sizeToFit.height)
        textView.superview?.transform = lastTextViewTransform ?? .identity
        
    }
    func textEndEditingTemplate(_ textView: UITextView, _ text: String?) {
        lastTextViewTransform = textView.superview?.transform
        textView.superview?.transform = .identity
        textView.text = text
        let sizeToFit = textView.sizeThatFits(CGSize(width: containerView.frame.width, height:CGFloat.greatestFiniteMagnitude))
        textView.superview?.frame.size = CGSize(width: sizeToFit.width, height: sizeToFit.height)
        textView.superview?.transform = lastTextViewTransform ?? .identity
        
    }
    func resizeAddItem(image: UIView){
        let width = image.frame.width
        let height = image.frame.height
        if width * hesonhan > containerView.frame.width {
            hesonhan -= 0.01
            resizeAddItem(image: image)
        }
        if height * hesonhan > containerView.frame.height {
            hesonhan -= 0.01
            resizeAddItem(image: image)
        }
        if width * hesonhan < 50 {
            hesonhan += 0.01
            resizeAddItem(image: image)
        }
        if height * hesonhan < 50 {
            hesonhan += 0.01
            resizeAddItem(image: image)
        }
        print("hesonhan: \(hesonhan)")
    }
    func addviews(imageview: UIView){
        let itemView = ItemContainerView()
        resizeAddItem(image: imageview)
        itemView.frame.size = CGSize(width: imageview.frame.width * hesonhan, height: imageview.frame.height * hesonhan)
        print("width: \(imageview.frame.width)")
        print("width: \(imageview.frame.height)")
        itemView.contentView = imageview
        itemView.delegate = self
        containerView.addSubview(itemView)
        itemView.center = containerViewImageBG.center
        itemView.hideAccesories(completion: nil)
        addGestures(view: itemView)
        self.listView.append(itemView)
        undoManager?.registerUndo(withTarget: self, handler: { (targetSelf) in
            targetSelf.deleteButtonTapped(item: itemView)
        })
        
        loadItemView()
        handleShowLayer()
    }
    func setTextInputView() {
        textInputView = TextInputView()
        textInputView?.translatesAutoresizingMaskIntoConstraints = false
        self.topView.addSubview(textInputView!)
        textInputView?.anchor(top: topView.topAnchor, leading: topView.leadingAnchor, bottom: topView.bottomAnchor, trailing: topView.trailingAnchor, padding: .zero)
        textInputView?.isHidden = true
        textInputView?.delegate = self
        print("text Input")
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            print("asdsa")
//            callRemoveBg(image: image)
            
            if isChangeImage == true{
                if ischangeBGImage == true {
                    changeBGImageView(image: image)
                }else{
                    changeImage(image: image)
                }
                isChangeImage = false
            } else {
//                let loading = self.displaySpinner(onView: view)
//                callRemoveBg(image: image, url: "https://api.remove.bg/v1.0/removebg", key: "gmdKE8QopSVbWFcHRYoPnZ2D"){
//                    response in
//                    print("response: \(response)")
//                    self.removeSpinner(spinner: loading)
////                    let img = UIImageView.init(image: response)
//                    self.addviews(imageview: UIImageView.init(image: response))
//                }
                addviews(imageview: UIImageView.init(image: image))
            }
        }

    }
    func addTemplate(){
        for i in itemArr {
            if i.type == "image"{
                addTempImage(image: i.view as! UIImageView, frame: i.frame, transform: i.transform, filter: i.filter, shadownValue: i.shadownValue, shadownType: i.gocDoBong)
                
            } else if i.type == "text" {
                activeItemView = nil
                activeTextView = nil
                addTempText(textViews: UITextView(), frame: i.frame, transform: i.transform, shadownValue: i.shadownValue, shadowntype: i.gocDoBong, textColor: i.textColor!, textBGColor: i.textBGColor!, font: i.font!, text: i.text!)
            }
        }
        
    }
    func addTempImage(image: UIImageView, frame: CGRect, transform: CGAffineTransform, filter: String?, shadownValue: CGFloat, shadownType: String){
        let itemView = ItemContainerView()
        itemView.frame = frame
        itemView.transform = transform
        itemView.valueShadown = shadownValue
        itemView.gocdobong = shadownType
        if filter != nil {
            itemView.contentView = image
        } else {
            itemView.contentImage = createAddFilter(view: image, filterName: filter!)
        }
        itemView.delegate = self
        containerView.addSubview(itemView)
        itemView.hideAccesories(completion: nil)
        addGestures(view: itemView)
        self.listView.append(itemView)
        
        loadItemView()
        
    }
    func addTempText(textViews: UITextView, frame: CGRect, transform: CGAffineTransform,shadownValue: CGFloat, shadowntype: String, textColor: UIColor, textBGColor: UIColor, font: UIFont, text: String){
        let textView = textViews
            textView.font = font
            textView.textColor = textColor
            textView.layer.backgroundColor = UIColor.clear.cgColor
            textView.isUserInteractionEnabled = false
        let itemView = ItemContainerView()
            itemView.frame = frame
            itemView.transform = transform
            itemView.valueShadown = shadownValue
            itemView.gocdobong = shadowntype
            itemView.textBackgroundColor = textBGColor
            itemView.contentView = textView
        textEndEditingTemplate(textView, text)
            itemView.delegate = self
        containerView.addSubview(itemView)
            itemView.hideAccesories()
        addGestures(view: itemView)
//        activeItemView = nil
        self.listView.append(itemView)
        
        loadItemView()
        
    }
    func preDelete(view: ItemContainerView){
        containerView.addSubview(view)
        view.hideAccesories(completion: nil)
        self.listView.append(view)
        loadItemView()
    }
    func preText(view: ItemContainerView,text: String?){
        if let textview = view.contentView as? UITextView {
            textview.text = text
            
        }
    }
    func resizeAddNewItem(image: UIView,width: CGFloat, height: CGFloat){
        let width = width
        let height = height
        if width * hesonhan > UIScreen.main.bounds.size.width - 40 {
            hesonhan -= 0.01
            resizeAddNewItem(image: image,width: width, height: height)
        }
        if height * hesonhan > UIScreen.main.bounds.size.height / 2 {
            hesonhan -= 0.01
            resizeAddNewItem(image: image,width: width, height: height)
        }
        if width * hesonhan < 50 {
            hesonhan += 0.01
            resizeAddNewItem(image: image,width: width, height: height)
        }
        if height * hesonhan < 50 {
            hesonhan += 0.01
            resizeAddNewItem(image: image,width: width, height: height)
        }
        print("hesonhan: \(hesonhan)")
    }
    func addNewProject(imageview: UIView, width: CGFloat, height: CGFloat){
        let itemView = ItemContainerView()
        resizeAddNewItem(image: imageview,width: width, height: height)
//        itemView.frame.size = CGSize(width: width * hesonhan, height: height * hesonhan)
        itemView.frame = CGRect(x: view.center.x, y: 100,width: width * hesonhan, height: height * hesonhan)
        print("width: \(imageview.frame.width)")
        print("width: \(imageview.frame.height)")
        itemView.contentView = imageview
        itemView.delegate = self
        containerView.addSubview(itemView)
//        itemView.center = containerViewImageBG.center
        itemView.hideAccesories(completion: nil)
        addGestures(view: itemView)
        self.listView.append(itemView)
        undoManager?.registerUndo(withTarget: self, handler: { (targetSelf) in
            targetSelf.deleteButtonTapped(item: itemView)
        })
        
        loadItemView()
    }
}
extension EditViewController:ItemViewDelegate,TextIputViewDelegate{
    func filterTapped(item: ItemContainerView) {
        
    }
    
    func deleteButtonTapped(item: ItemContainerView) {
        undoManager?.registerUndo(withTarget: self, handler: { TargetType in
            TargetType.preDelete(view: item)
        })
        item.removeFromSuperview()
        activeItemView = nil
        backButton()
        for e in 0..<listView.count{
            if(listView[e] == item){
                listView.remove(at: e)
                loadItemView()
                break
            }
        }
    }
    
    func itemBeginResizing(item: ItemContainerView) {
        item.gestureRecognizers?.forEach(item.removeGestureRecognizer)
    }
    
    func itemDidResize(item: ItemContainerView) {
        
    }
    
    func itemDidEndResizing(item: ItemContainerView) {
        addGestures(view: item)
//        undoManager?.registerUndo(withTarget: self, handler: { (targetSelf) in
//            targetSelf.preFrame(view: item, frame: item.preFrame!)
//        })
//        undoManager?.registerUndo(withTarget: self, handler: { (targetSelf) in
//            targetSelf.preTranform(view: item, tranform: item.preTranform!)
//        })
    }
    
    func textViewBeginEdit(item: ItemContainerView, text: String?) {
        undoManager?.registerUndo(withTarget: self, handler: { TargetType in
            TargetType.preText(view: item, text: text)
        })
        navigationBarText()
        isTyping = true
        textInputView?.isHidden = false
        textInputView?.value = text
        textInputView?.textField.becomeFirstResponder()
    }
    
    func doneAddText(item: TextInputView) {
        doneadd()
    }
    
    func loadItemView(){
        self.bottomLayerView.itembottomMenuCollection.data = self.listView
        self.bottomLayerView.itembottomMenuCollection.reloadData()
    }
}
