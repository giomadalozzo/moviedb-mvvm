//
//  MovieTableViewModel.swift
//  moviedb-mvvm
//
//  Created by Luiz Eduardo Mello dos Reis on 08/03/22.
//

import UIKit

protocol MovieTableViewModelProtocol: AnyObject {
    func reloadTableViewData()
}

class MovieTableViewModel {
    init(){
        getGenres()
    }
    
    var moviesPopular: [Film] = []
    var moviesPlaying: [Film] = []
    let apirequest = MovieAPI()
    var localGenresArray: [Genres] = []
    
    weak var delegate:MovieTableViewModelProtocol?
    
    func getGenres() {
        apirequest.requestGenres { genresArray in
            self.localGenresArray = genresArray
        }
    }
    
    func getPopularMovies(){
        apirequest.requestPopularMovies(localGenresArray: self.localGenresArray) { [weak self] moviesPopular in
            guard let self = self else {return}
            self.moviesPopular = moviesPopular
            self.delegate?.reloadTableViewData()
        }
    
    }
    
    func getNowPlayingMovies(){
        apirequest.requestPopularMovies(localGenresArray: self.localGenresArray) { [weak self] moviesPlaying in
            guard let self = self else {return}
            self.moviesPlaying = moviesPlaying
            
            self.delegate?.reloadTableViewData()
        }
    }
}

