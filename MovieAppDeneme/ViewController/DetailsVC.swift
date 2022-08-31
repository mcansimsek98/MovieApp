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

    var selectedTitle: String?
    var selectedBody : String?
    var selectedImage : String?
    var scrollView: UIScrollView!
    var selectedOriginalTitle: String?
    var selectedPopularity: Double?
    var selectedReleaseDate: String?
    var selectedVoteCount: Int?
    var selectedLanguage: String?
    var selectedArray: TheMovie?
    
    var languageText = ""
    var popularityText = ""
    var bodyText = ""
    var relaseDateText = ""
    var orginalTitle = ""
    var voteCounText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDetailData()
    }
}

extension DetailsVC {
    func getDetailData() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButton))
        
        if selectedTitle == selectedTitle { titleLbl.text = selectedTitle }
        if selectedBody == selectedBody { bodyText = selectedBody ?? "" }
        if selectedPopularity == selectedPopularity { popularityText = "\(selectedPopularity ?? 0000)"}
        if selectedReleaseDate == selectedReleaseDate { relaseDateText = selectedReleaseDate ?? ""  }
        if selectedOriginalTitle == selectedOriginalTitle {   orginalTitle = selectedOriginalTitle   ?? "" }
        if selectedVoteCount == selectedVoteCount { voteCounText = "\(selectedVoteCount ?? 000)"}
        if selectedLanguage == selectedLanguage { languageText = "\(selectedLanguage ?? "")"}
            textView.text = """
Original Title: \(orginalTitle.uppercased())

Language: \(languageText.uppercased())

Release Date: \(relaseDateText.uppercased())

Popularity: \(popularityText.uppercased())

Vote Count: \(voteCounText.uppercased())

   \(bodyText)

"""
        if selectedImage == selectedImage {
            let imageUrl: NSURL? = NSURL(string: selectedImage ?? "")
            if let imageUrl = imageUrl {
                imageView.sd_setImage(with: imageUrl as URL)
            }
        }
    }
    
    @objc func shareButton() {
        let item = selectedArray?.title ?? ""
        let vc = UIActivityViewController(activityItems: [item], applicationActivities: [] )
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
}

