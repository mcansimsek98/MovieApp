//
//  ExtentionDetails.swift
//  MovieAppDeneme
//
//  Created by Mehmet Can Şimşek on 31.08.2022.
//

import UIKit

extension DetailsVC {
    
    func getDetailData() {
        titleLbl.text = selectedArray?.original_title ?? ""
        bodyText = selectedArray?.overview ?? ""
        popularityText = "\(selectedArray?.popularity ?? 000)"
        relaseDateText = selectedArray?.release_date ?? ""
        orginalTitle = selectedArray?.original_title ?? ""
        voteCounText = "\(selectedArray?.vote_count ?? 000)"
        languageText = "\(selectedArray?.original_language ?? "")"

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
        image = selectedArray?.backdrop_path ?? ""
        let url = "https://image.tmdb.org/t/p/w500\(image)"
        let imageUrl: NSURL? = NSURL(string: url)
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
