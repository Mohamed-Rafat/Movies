//
//  FavouriteMoviesViewController.swift
//  Movies
//
//  Created by MohamedRafat on 6/7/19.
//  Copyright © 2019 ATeam. All rights reserved.
//

import UIKit

class FavouriteMoviesViewController: ViewControllerWelcomeAndLogOut {

    // MARK: - Outlets
    @IBOutlet weak var favouriteTblView: UITableView!
    
    // MARK: - Properties
    private var _presenter: FavouriteMoviesPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _presenter = FavouriteMoviesPresenter(viewController: self)
        
        setupMovieCell()
        favouriteTblView.delegate = self
        favouriteTblView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _presenter?.getFavMovies()
    }
    
    private func setupMovieCell(){
        let nib = UINib(nibName: CellIdentifiers.MovieViewCell.rawValue, bundle: Bundle(for: type(of: self)))
        self.favouriteTblView.register(nib, forCellReuseIdentifier: CellIdentifiers.MovieViewCell.rawValue)
    }
    
    func reloadFavTblData(){
        favouriteTblView.reloadData()
    }

}

extension FavouriteMoviesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if _presenter?.getFavMoviesCount() == 0{
            tableView.setEmptyMessage("You have no Favourite Movies.")
        }else {
            tableView.restore()
        }
        return _presenter?.getFavMoviesCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MovieViewCell.rawValue, for: indexPath) as! MovieViewCell
        cell.isFavourite = true
        cell.delegate = self
        cell.configMovieCell(movie: (_presenter?.getMovie(at: indexPath.row))!, source: .FavouriteMovies)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetailsVC = MovieDetailsViewController.instantiate(fromAppStoryboard: .MovieDetails)
        movieDetailsVC.selectedMovie = _presenter?.getMovie(at: indexPath.row)
        present(MainNavigationController(rootViewController: movieDetailsVC), animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if Device.IS_IPHONE{
            return 200
        }
        return 500
    }
    
}


extension FavouriteMoviesViewController: MovieViewCellDelegate {
    
    func setToFav(cell: MovieViewCell) {
    _presenter?.setInFav(movieID: cell._movie.id ?? 0)
    }
    
    func removeFromFav(cell: MovieViewCell) {
        _presenter?.removeFavMovie(movieID: cell._movie.id ?? 0)
    }
}
