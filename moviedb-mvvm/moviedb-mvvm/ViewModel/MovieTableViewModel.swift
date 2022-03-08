//
//  MovieTableViewModel.swift
//  moviedb-mvvm
//
//  Created by Luiz Eduardo Mello dos Reis on 08/03/22.
//

import UIKit

class MovieTableViewModel: UIViewController {
    
    var movies: [Film] = []
    let apirequest = MovieAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

