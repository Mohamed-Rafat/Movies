//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by MohamedRafat on 6/7/19.
//  Copyright © 2019 ATeam. All rights reserved.
//

import UIKit

class MovieDetailsViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var movieThumbnailImgView: UIImageView!
    @IBOutlet weak var movieNameLbl: UILabelX!
    @IBOutlet weak var movieGentresLbl: UILabelX!
    @IBOutlet weak var movieYearLbl: UILabelX!
    @IBOutlet weak var movieDirectorLbl: UILabelX!
    @IBOutlet weak var movieMainStarLbl: UILabelX!
    @IBOutlet weak var movieDescLbl: UILabelX!
    @IBOutlet weak var DirectorStackView: UIStackView!
    @IBOutlet weak var mainStarStackView: UIStackView!
    @IBOutlet weak var descStackView: UIStackView!
    
    
    
    // MARK: - Properties
    var selectedMovie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation(backImage: BackImage.wightLeftBack, isTranslucent: true)
        setupMovieInfo()
    }
    
    func setupMovieInfo(){
        guard let movie = selectedMovie, let name = movie.name, let year = movie.year, let gentres = movie.gentres else { return }
         setNavigationTitle(title: name, color: ColorPalette.navigationTitleColor, font: Fonts.titleFont)
        movieNameLbl.text = name
        movieYearLbl.text = "\(year)"
        movieGentresLbl.text = ""
        for (i, gentre) in gentres.enumerated() {
            movieGentresLbl.text?.append(gentre.name ?? "")
            if i < gentres.count - 1 {
                movieGentresLbl.text?.append(",  ")
            }
        }
        
        movieDirectorLbl.text = movie.director ?? ""
        movieMainStarLbl.text = movie.mainStar ?? ""
        movieDescLbl.text = movie.descriptionField ?? ""
        
        loadThumbnail(urlStr: movie.thumbnail ?? "")
        
    }
    
    func loadThumbnail(urlStr: String) {
        let imgUrl = URL(string: urlStr)
        movieThumbnailImgView?.kf.indicatorType = .activity
        movieThumbnailImgView?.kf.setImage(with: imgUrl, placeholder: #imageLiteral(resourceName: "defalult_thumbnail"))
    }
}
