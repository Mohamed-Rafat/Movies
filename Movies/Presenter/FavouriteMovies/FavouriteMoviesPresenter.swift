//
//  FavouriteMoviesPresenter.swift
//  Movies
//
//  Created by MohamedRafat on 6/8/19.
//  Copyright © 2019 ATeam. All rights reserved.
//

import Foundation

class FavouriteMoviesPresenter{
    
    private var _viewControllerDelegate: FavouriteMoviesViewController?
    private var _favMovies = [Movie]()
    
    init(viewController: FavouriteMoviesViewController) {
        self._viewControllerDelegate = viewController
    }
    
    func getFavMovies(){
        LocalCache().getUser { (user) in
            guard let user = user, let id = user.id else { return }
            self.getFavouriteMovies(userID: id)
        }
    }
    
    private func getFavouriteMovies(userID: Int){
        _viewControllerDelegate?.showLoadingView()
        let request = BaseRequest(path: Urls.FavMovies(userID: userID).getUrlStr(), HTTPMethod: .get, task: .request, headers: nil)
        APIRequest().start(request: request) { (result: Result<[Movie], NetworkResponse>) in
            switch result {
            case .success(let movies):
                self._favMovies = movies
                self._viewControllerDelegate?.reloadFavTblData()
                self._viewControllerDelegate?.hideLoadingView()
            case .failure(let error):
                self._viewControllerDelegate?.hideLoadingView()
                self._viewControllerDelegate?.showAlertWithOk(title: "Error", message: error.getErrorMsg())
            }
        }
    }
    
    func getFavMoviesCount() -> Int {
        return _favMovies.count
    }
    
    func getMovie(at index: Int) -> Movie {
        return _favMovies[index]
    }
    
    func setInFav(movieID: Int){
        LocalCache().getUser { (user) in
            guard let user = user, let id = user.id else { return }
            self.setMovieInFavList(movieID: movieID, userID: id)
        }
    }
    
    func removeFavMovie(movieID: Int) {
        LocalCache().getUser { (user) in
            guard let user = user, let id = user.id else { return }
            self.removeMovieFromFavList(movieID: movieID, userID: id)
        }
    }
    
    
    
    private func setMovieInFavList(movieID: Int, userID: Int){
        let request = BaseRequest(path: Urls.SetToFav(userID: userID, movieID: movieID).getUrlStr(), HTTPMethod: .get, task: .request, headers: nil)
        APIRequest().start(request: request) { (result: Result<[Movie], NetworkResponse>) in
            switch result {
            case .success(_): break
            case .failure(let error):
                self._viewControllerDelegate?.showAlertWithOk(title: "Error", message: error.getErrorMsg())
            }
        }
    }
    
    private func removeMovieFromFavList(movieID: Int, userID: Int){
        let request = BaseRequest(path: Urls.RemoveFromFav(userID: userID, movieID: movieID).getUrlStr(), HTTPMethod: .get, task: .request, headers: nil)
        APIRequest().start(request: request) { (result: Result<[Movie], NetworkResponse>) in
            switch result {
            case .success(let movies):
                self._favMovies = movies
                self._viewControllerDelegate?.reloadFavTblData()
            case .failure(let error):
                self._viewControllerDelegate?.showAlertWithOk(title: "Error", message: error.getErrorMsg())
            }
        }
    }
}
