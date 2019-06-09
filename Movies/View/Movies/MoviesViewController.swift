//
//  ViewController.swift
//  Movies
//
//  Created by MohamedRafat on 6/5/19.
//  Copyright © 2019 ATeam. All rights reserved.
//

import UIKit

class MoviesViewController: ViewControllerWelcomeAndLogOut {
    
    // MARK: - Outlets
    @IBOutlet weak var moviesTblView: UITableView!
    
    // MARK: - Properties
    private var _presenter: MoviesPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _presenter = MoviesPresenter(viewController: self)
        _presenter?.getMovies()
        
        setupMovieCell()
        moviesTblView.delegate = self
        moviesTblView.dataSource = self
    }
    
    private func setupMovieCell(){
        let nib = UINib(nibName: CellIdentifiers.MovieViewCell.rawValue, bundle: Bundle(for: type(of: self)))
        self.moviesTblView.register(nib, forCellReuseIdentifier: CellIdentifiers.MovieViewCell.rawValue)
    }
    
    func reloadMoviesTblData(){
        moviesTblView.reloadData()
    }
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _presenter?.getMoviesCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MovieViewCell.rawValue, for: indexPath) as! MovieViewCell
        cell.delegate = self
        cell.configMovieCell(movie: (_presenter?.getMovie(at: indexPath.row))!, source: .Movies)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetailsVC = MovieDetailsViewController.instantiate(fromAppStoryboard: .MovieDetails)
        movieDetailsVC.selectedMovie = _presenter?.getMovie(at: indexPath.row)
        present(MainNavigationController(rootViewController: movieDetailsVC), animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if Device.IS_IPHONE {
            return 200
        }
        return 500
    }
}

extension MoviesViewController: MovieViewCellDelegate {
    
    func setToFav(cell: MovieViewCell) {
        _presenter?.setInFav(movieID: cell._movie.id ?? 0)
    }
    
    func removeFromFav(cell: MovieViewCell) {
        _presenter?.removeFavMovie(movieID: cell._movie.id ?? 0)
    }
}
