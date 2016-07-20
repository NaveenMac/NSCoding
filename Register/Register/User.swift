//
//  User.swift
//  Register
//
//  Created by Naveen on 20/07/16.
//  Copyright © 2016 naveen. All rights reserved.
//

import UIKit

class User: NSObject, NSCoding {
  // MARK: Properties
  var name: String
  
  var photo: UIImage?
  
  // MARK: Archiving Paths
  static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
  static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("users")
  
  // MARK: Types
  
  struct PropertyKey {
    static let nameKey = "name"
    static let photoKey = "photo"
  }
  
  // MARK: Initialisation
  
  init?(name: String, photo: UIImage?) {
    // Initialize stored properties.
    self.name = name
    self.photo = photo
    
    super.init()
    
    // Initialization should fail if there is no name or if the rating is negative.
    if name.isEmpty{
      return nil
    }
  }
  
  func  encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(self.name, forKey: PropertyKey.nameKey)
    aCoder.encodeObject(self.photo, forKey: PropertyKey.photoKey)
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
    
    // Because photo is an optional property of Meal, use conditional cast.
    let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
    // Must call designated initializer.
    self.init(name: name, photo: photo)
  }
  
  
}
