//
//  ExtentionDetails.swift
//  MovieAppDeneme
//
//  Created by Mehmet Can Şimşek on 31.08.2022.
//

import UIKit

extension DetailsVC {
    
    func getDetailData() {
        titleLbl.text = selectedArray?.title ?? ""
        bodyText = selectedArray?.bodyLbl ?? ""
        popularityText = "\(selectedArray?.popularaty ?? 000)"
        relaseDateText = selectedArray?.relaseDate ?? ""
        orginalTitle = selectedArray?.orginalTitle ?? ""
        voteCounText = "\(selectedArray?.voteCont ?? 000)"
        languageText = "\(selectedArray?.language ?? "")"

            textView.text = """
Original Title: \(orginalTitle.uppercased())

Language: \(languageText.uppercased())

Release Date: \(relaseDateText.uppercased())

Popularity: \(popularityText.uppercased())

Vote Count: \(voteCounText.uppercased())

   \(bodyText)

"""
    }
    
    func getImage() {
        image = selectedArray?.bacDropPath ?? ""
        let imageUrl: NSURL? = NSURL(string: image)
        if let imageUrl = imageUrl {
            imageView.sd_setImage(with: imageUrl as URL)
        }
    }
    
    @objc func shareButton() {
        let item = selectedArray?.title ?? ""
        let vc = UIActivityViewController(activityItems: [item], applicationActivities: [] )
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
}
