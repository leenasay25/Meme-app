//
//  AppDelegate.swift
//  Meme Me Version 2
//
//  Created by Leena Alsayari on 17/12/2022.
//

//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
 
    var window: UIWindow?
    var memes = [Meme]()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // loading memes
        loadMemes() // removed self
        return true
    }
    
    func loadMemes() {
        let memes = [
            Meme(topTextField: "U D A C I T Y", bottomtextField: "R O C K S", originalImage: UIImage(named: "placeholder")!, memedImage: UIImage(named: "1")!),
            Meme(topTextField: "WHEN YOURE AT WORK", bottomtextField: "TRYNG TO STAY POSATIVE", originalImage: UIImage(named: "placeholder")!, memedImage: UIImage(named: "2")!),
            Meme(topTextField: "YOURE A FUNNY GUY", bottomtextField: "I LIKE THAT", originalImage: UIImage(named: "placeholder")!, memedImage: UIImage(named: "3")!),
            Meme(topTextField: "WHAT IF 666", bottomtextField: "IS THE SQUARE ROOT", originalImage: UIImage(named: "placeholder")!, memedImage: UIImage(named: "4")!),
            Meme(topTextField: "BE THERE", bottomtextField: "OR BE SQUARE", originalImage: UIImage(named: "placeholder")!, memedImage: UIImage(named: "5")!),
            Meme(topTextField: "NEED AN ARC?", bottomtextField: "I NOAH GUY", originalImage: UIImage(named: "placeholder")!, memedImage: UIImage(named: "6")!)
        ]
        
        for meme in memes {
            self.memes.append(meme)
            print(meme)
        }
        
    }
     

}

