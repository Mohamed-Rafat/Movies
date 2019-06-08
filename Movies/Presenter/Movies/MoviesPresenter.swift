//
//  MoviesPresenter.swift
//  Movies
//
//  Created by MohamedRafat on 6/8/19.
//  Copyright © 2019 ATeam. All rights reserved.
//

import Foundation

class MoviesPresenter {
    
    private var _viewControllerDelegate: MoviesViewController?
    private var _movies = [Movie]()
    
    init(viewController: MoviesViewController) {
        self._viewControllerDelegate = viewController
    }
    
    func getMovies(){
        _viewControllerDelegate?.showLoadingView()
        let request = BaseRequest(path: Urls.AllMovies.getUrlStr(), HTTPMethod: .get, task: .request, headers: nil)
        APIRequest().start(request: request) { (result: Result<[Movie], NetworkResponse>) in
            switch result{
            case .success(let movies):
                self._viewControllerDelegate?.hideLoadingView()
                self._movies = movies
                self._viewControllerDelegate?.reloadMoviesTblData()
            case .failure(let error):
                self._viewControllerDelegate?.hideLoadingView()
                self._viewControllerDelegate?.showAlertWithOk(title: "Error", message: error.getErrorMsg())
            }
        }
    }
    
    func getMoviesCount()-> Int {
        return _movies.count
    }
    
    func getMovie(at index: Int) -> Movie{
        return _movies[index]
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
            case .success(_):
              break
            case .failure(let error):
                self._viewControllerDelegate?.showAlertWithOk(title: "Error", message: error.getErrorMsg())
            }
        }
    }
}
