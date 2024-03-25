//
//  MemesCollectionViewController
//  Meme Me Version 2
//
//  Created by Leena Alsayari on 17/12/2022.
//


import UIKit

class MemesCollectionViewController: UICollectionViewController {
    
    // MARK: UIImage vars
    var memes = [Meme]()
    let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutCells()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memes = appDelegate.memes       // removed self
        collectionView.reloadData()    // removed self
        navigationItem.title = "Sent Memes"     // removed self
        collectionView?.backgroundColor = UIColor.white      // removed self
    }
    

    struct Constants {
        static let CellVerticalSpacing: CGFloat = 2
    }
 
    func layoutCells() {
        var cellWidth: CGFloat
        var numWide: CGFloat
        
        //sets the number of cells to display horizontally in each row based on the device's orientation
        switch UIDevice.current.orientation {
        case .portrait:
            numWide = 3
        case .portraitUpsideDown:
            numWide = 3
        case .landscapeLeft:
            numWide = 4
        case .landscapeRight:
            numWide = 4
        default:
            numWide = 4
        }
        
        cellWidth = collectionView!.frame.width / numWide
        cellWidth -= Constants.CellVerticalSpacing
        flowLayout.itemSize.width = cellWidth
        flowLayout.itemSize.height = cellWidth
        flowLayout.minimumInteritemSpacing = Constants.CellVerticalSpacing
        let actualCellVerticalSpacing: CGFloat = (collectionView!.frame.width - (numWide * cellWidth))/(numWide - 1)
        flowLayout.minimumLineSpacing = actualCellVerticalSpacing
        flowLayout.invalidateLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collectionView!.reloadData()
    }
    
    // MARK: Set up Collection View
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let meme = self.memes[indexPath.row]
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath as IndexPath) as! CollectionViewCell
          cell.memeImage.image = meme.memedImage
          cell.memeImage.contentMode = UIView.ContentMode.scaleAspectFill
          return cell
      }
    
    // MARK: Push details VC
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailViewController.meme = self.memes[indexPath.row]
        self.navigationController!.pushViewController(detailViewController, animated: true)
    }
    
   func prefersStatusBarHidden() -> Bool {
        return true     // status bar should be hidden
    }
}
