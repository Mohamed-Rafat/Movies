//
//  MovieViewCell.swift
//  Movies
//
//  Created by MohamedRafat on 6/7/19.
//  Copyright © 2019 ATeam. All rights reserved.
//

import UIKit
import Kingfisher

protocol  MovieViewCellDelegate {
    func setToFav(cell: MovieViewCell)
    func removeFromFav(cell: MovieViewCell)
}

enum SourceTable{
    case Movies
    case FavouriteMovies
}

class MovieViewCell: UITableViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var movieImgView: UIImageView!
    @IBOutlet weak var movieNameLbl: UILabelX!
    @IBOutlet weak var movieYearLbl: UILabelX!
    @IBOutlet weak var movieGenreLbl: UILabelX!
    
    
    @IBOutlet weak var FavBtn: LoveButton!

    
    // MARK: - Properties
    var isFavourite: Bool = false{
        didSet{
            FavBtn.isLoved = isFavourite
        }
    }
    var source: SourceTable = .Movies
    var _movie: Movie!
    var delegate: MovieViewCellDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configMovieCell(movie: Movie, source: SourceTable) {
         FavBtn.isLoved = isFavourite
        self.source = source
        self._movie = movie
        movieNameLbl.text = movie.name ?? ""
        movieYearLbl.text = "\(movie.year ?? 0)"
        movieGenreLbl.text = movie.gentres?.first?.name ?? ""
        getThumbnailImg(urlStr: movie.thumbnail ?? "")
    }
    
    func getThumbnailImg(urlStr: String){
        let imgUrl = URL(string: urlStr)
        movieImgView?.kf.indicatorType = .activity
        movieImgView?.kf.setImage(with: imgUrl, placeholder: #imageLiteral(resourceName: "defalult_thumbnail"))
    }
    
    // MARK: - Actions
    @IBAction func onFavBtnPressed(_ sender: LoveButton) {
        sender.isLoved = !sender.isLoved!
        if sender.isLoved! {
            delegate?.setToFav(cell: self)
        }else {
            delegate?.removeFromFav(cell: self)
        }
    }
    
    
}
