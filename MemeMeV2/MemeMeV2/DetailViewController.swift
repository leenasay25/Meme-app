//
//  DetailViewController.swift
//  Meme Me Version 2
//
//  Created by Leena Alsayari on 17/12/2022.
//


import UIKit

class DetailViewController: UIViewController {
    
    var meme: Meme! = nil
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imageView.image = meme.memedImage
    }
    
    @IBAction func cancelAction(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func prefersStatusBarHidden() -> Bool {
        return true    
    }
}
