//
//  UserDetailViewController.swift
//  Register
//
//  Created by Naveen on 20/07/16.
//  Copyright © 2016 naveen. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  var user:User?
  
  
 
  @IBOutlet weak var saveButton: UIBarButtonItem!
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      self.nameTextField.delegate = self
      
      if let user = user{
        navigationItem.title = user.name
        self.nameTextField.text = user.name
        self.photoImageView.image = user.photo
      }
      
      checkValidUserName()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  
   // MARK: Textfield Delegate
  
  func  textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  func textFieldDidBeginEditing(textField: UITextField) {
    saveButton.enabled = false
  }
  func  textFieldDidEndEditing(textField: UITextField) {
    checkValidUserName()
    navigationItem.title = textField.text
    
  }
  
  func checkValidUserName(){
   let text = nameTextField.text ?? ""
   saveButton.enabled = !text.isEmpty
  }

  
  // MARK: UIImagePickerControllerDelegate
  func  imagePickerControllerDidCancel(picker: UIImagePickerController) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
    photoImageView.image = selectedImage
    dismissViewControllerAnimated(true, completion: nil)
  }
  @IBAction func cancel(sender: AnyObject) {
    
    let isPresentingInAddUserMode = presentingViewController is UINavigationController
    
    if isPresentingInAddUserMode{
      dismissViewControllerAnimated(true, completion: nil)
    }else{
      navigationController!.popViewControllerAnimated(true)
    }
  }

  
  @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
    nameTextField.resignFirstResponder()
    let imagePickerController = UIImagePickerController()
    imagePickerController.sourceType = .PhotoLibrary
    imagePickerController.delegate = self
    presentViewController(imagePickerController, animated: true, completion: nil)
    
  }
  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
      if saveButton === sender{
         let name = nameTextField.text ?? ""
         let photo = photoImageView.image
         user = User(name: name, photo: photo)
      }
    }
  

}
