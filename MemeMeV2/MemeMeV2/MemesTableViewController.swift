//
//  MemesTableViewController
//  Meme Me Version 2
//
//  Created by Leena Alsayari on 17/12/2022.
//


import UIKit

class MemesTableViewController: UITableViewController, UIViewControllerTransitioningDelegate {
    
    var memes = [Meme]()
    let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memes = appDelegate.memes
        tableView.reloadData()
        navigationItem.title = "Sent Memes"
        
        
    }
    
    // MARK: Set up tableview
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let meme = self.memes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath as IndexPath) as! TableViewCell
        cell.cellLabel.text = "\(meme.topTextField ?? "no text") ... \(meme.bottomtextField ?? "no text")"
        cell.memeImage.image = meme.memedImage
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailViewController.meme = self.memes[indexPath.row]
        navigationController!.pushViewController(detailViewController, animated: true)  // removed self
    }
    
    // MARK: removes item
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCell.EditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            appDelegate.memes.remove(at: indexPath.row) 
            memes.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }

   func prefersStatusBarHidden() -> Bool {
        return true
    }
}
