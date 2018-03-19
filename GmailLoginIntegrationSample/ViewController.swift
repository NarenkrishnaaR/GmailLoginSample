//
//  ViewController.swift
//  GmailLoginIntegrationSample
//
//  Created by Naren on 19/03/18.
//  Copyright © 2018 naren. All rights reserved.
//

import UIKit
import Google
import GoogleSignIn

class ViewController: UIViewController,GIDSignInUIDelegate,GIDSignInDelegate {
  
  @IBOutlet weak var lblUserName: UILabel!
  
  var error: NSError?
  
  @IBOutlet weak var btnSignOut: UIButton!
  let googleSignInButton = GIDSignInButton()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    GGLContext.sharedInstance().configureWithError(&error)
    btnSignOut.isHidden = true
    if error != nil{
      print(error ?? "google error")
      return
    }
    GIDSignIn.sharedInstance().uiDelegate = self
    GIDSignIn.sharedInstance().delegate = self
    googleSignInButtonFunc()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func googleSignInButtonFunc(){
    googleSignInButton.center = view.center
    view.addSubview(googleSignInButton)
  }
  
  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
    if error != nil{
      print(error ?? "google error")
      return
    }
    lblUserName.text = user.profile.name
    btnSignOut.isHidden = false
    googleSignInButton.isHidden = true
  }
  
  @IBAction func btnSignOut(_ sender: Any) {
    GIDSignIn.sharedInstance().signOut()
    lblUserName.text = ""
    btnSignOut.isHidden = true
    googleSignInButton.isHidden = false
  }
  
}

