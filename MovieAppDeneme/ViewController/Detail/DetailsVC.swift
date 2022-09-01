//
//  DetailsVC.swift
//  MovieAppDeneme
//
//  Created by Mehmet Can Şimşek on 29.08.2022.
//

import UIKit

class DetailsVC: UIViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var textView: UITextView!

    var selectedArray: HomeViewModel?
    
    var languageText = ""
    var popularityText = ""
    var bodyText = ""
    var relaseDateText = ""
    var orginalTitle = ""
    var voteCounText = ""
    var image = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButton))
        guard selectedArray != nil else {return}
        getDetailData()
        getImage()
    }
}




