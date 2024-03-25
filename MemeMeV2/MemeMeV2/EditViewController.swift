//
//  EditViewController
//  Meme Me Version 2 Branch from Version 1
//
//  Created by Leena Alsayari on 17/12/2022.
//

import UIKit

class EditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // MARK: UIImage and text vars
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var navBar: UIToolbar!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var share: UIBarButtonItem!
    var memedImage: UIImage!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        setTextFields(textInput: topTextField, defaultText: "TOP")
        setTextFields(textInput:  bottomTextField, defaultText: "BOTTOM")
        
        #if targetEnvironment(simulator)
        cameraButton.isEnabled = false;
        #else
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera);
        #endif
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    // MARK: pick image or camera
    func pickImage(source: UIImagePickerController.SourceType){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = source
        share.isEnabled = true
        present(pickerController, animated: true, completion: nil)
    }
    @IBAction func pickAnImage(sender: AnyObject) {
        pickImage(source: UIImagePickerController.SourceType.photoLibrary)
    }
    
    @IBAction func pickCamera(sender: AnyObject) {
        pickImage(source: UIImagePickerController.SourceType.camera)
    }
    

    @IBAction func share(sender: AnyObject) {
        let shareMeme = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [shareMeme], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { activity, success, items, error in
            if success {
                self.saveMeme(memedImage: shareMeme)
            }
        }
        present(activityViewController, animated: true, completion: nil)
        
    }

    @IBAction func cancel(sender: AnyObject) {
        imageView.image = nil
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        dismiss(animated: true, completion: {})
    }
    @IBAction func done (sender: AnyObject) {
       
        dismiss(animated: true, completion: nil)
    }
    
    private func imagePickerControllerDidCancel(_picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: get image
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage") ] as? UIImage {
            imageView.image = image //show image into the imageView
            
        }
        
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK:  defualt text field attributes
    func setTextFields(textInput: UITextField!, defaultText: String) {
        let memeTextAttributes = [
            NSAttributedString.Key.strokeColor : UIColor.black,
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedString.Key.strokeWidth : -3.0 ] as [NSAttributedString.Key : Any]
        textInput.text = defaultText
        textInput.defaultTextAttributes = memeTextAttributes
        textInput.delegate = self
        textInput.textAlignment = .center
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if topTextField.text == "TOP" ||  bottomTextField.text == "BOTTOM" {
            textField.text = ""
        }
    }
    
    // MARK: hide keyboard with return 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    // MARK: hide keyboard with click
    func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    // MARK:  NSNotification subscriptions
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification , object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
          if  bottomTextField.isFirstResponder && view.frame.origin.y == 0.0{
              view.frame.origin.y -= getKeyboardHeight(notification: notification)
          }
      }

      @objc func keyboardWillHide(_ notification: NSNotification) {
          if  bottomTextField.isFirstResponder {
              view.frame.origin.y = 0
          }
      }
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
 
    
    // MARK: generate meme
    func generateMemedImage() -> UIImage {
        
        toolBarVisible(visible: false)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        memedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        toolBarVisible(visible: true)
        
        return memedImage
    }
    // MARK: save meme
    func saveMeme(memedImage: UIImage) {
        if imageView.image != nil && topTextField.text != nil &&  bottomTextField.text != nil
        {
            let top = self.topTextField.text!
            let bottom = self.bottomTextField.text!
            let image = self.imageView.image!
            
            let meme = Meme(topTextField: top,  bottomtextField: bottom, originalImage: image, memedImage: memedImage)
            (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
            
        }
    }

    func toolBarVisible(visible: Bool){
        if !visible {
            navBar.isHidden = true    // removed self
            toolBar.isHidden = true // typo on var for toolbar // removed self
        } else {
            navBar.isHidden = false   // removed self
            toolBar.isHidden = false  // removed self
        }
    }

    
     func prefersStatusBarHidden() -> Bool {
        return true     // status bar should be hidden
    }
}
