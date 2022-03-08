//
//  ViewController.swift
//  moviedb-mvvm
//
//  Created by Giovanni Madalozzo on 04/03/22.
//

import UIKit

class MainView: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let movieViewModel = MovieTableViewModel()
    var moviesVM = MovieTableViewModel().movies
    let apiVM = MovieTableViewModel().apirequest

    
    @IBOutlet weak var movieTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTable.delegate = self
        movieTable.dataSource = self
        
        apiVM.requestPopularMovies { (movies) in
            self.moviesVM = movies
            
            DispatchQueue.main.async{
                self.movieTable.reloadData()
            }
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieTable.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath) as? MovieTableCell
        
        let movies = moviesVM[indexPath.row]
        
        cell?.titleLabel.text = movies.title
        cell?.aboutLabel.text = movies.description
        cell?.starsLabel.text = movies.overview
        
        // # Need to change Film Model image atribute to String (or make a function to convert it)
        
        // cell?.posterImage.image = UIImage(named: movies.image)
        
        return cell!
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Lembrem-se de colocar um booleano pra controlar as requisições
        // E lembrem-se de controlarem em que página estamos para pedirmos apenas a próxima
        if (indexPath.row == moviesVM.count - 1) {
            apiVM.requestPopularMovies() { (movies) in
                self.moviesVM.append(contentsOf: movies)
                
                DispatchQueue.main.async {
                    self.movieTable.reloadData()
                }
            }
        }
    }
}
