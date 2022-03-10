//
//  ViewController.swift
//  moviedb-mvvm
//
//  Created by Giovanni Madalozzo on 04/03/22.
//

import UIKit

class MainView: UIViewController, UITableViewDelegate, UITableViewDataSource, MovieTableViewModelProtocol{
    
    let movieViewModel = MovieTableViewModel()
    var moviesPopular = MovieTableViewModel().moviesPopular
    var moviesPlaying = MovieTableViewModel().moviesPlaying
    let apiVM = MovieTableViewModel().apirequest

    
    @IBOutlet weak var movieTable: UITableView!
    
    func reloadTableViewData() {
        DispatchQueue.main.async {
            self.movieTable.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieViewModel.delegate = self
        movieTable.delegate = self
        movieTable.dataSource = self
        movieViewModel.getPopularMovies()
        movieViewModel.getNowPlayingMovies()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Popular Movies"
        }else{
            return "Now Playing"
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor.white
        (view as! UITableViewHeaderFooterView).textLabel?.font = UIFont(name: "System Bold", size: 17)
        (view as! UITableViewHeaderFooterView).textLabel?.textColor = UIColor.black
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return movieViewModel.moviesPopular.count
        }else{
            return movieViewModel.moviesPlaying.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieTable.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath) as? MovieTableCell
        
        if indexPath.section == 0{
            let movies = movieViewModel.moviesPopular[indexPath.row]
            
            cell?.titleLabel.text = movies.title
            cell?.aboutLabel.text = movies.overview
            cell?.starsLabel.text = String(movies.voteAverage)
            cell?.starImage.image = UIImage(systemName: "star")
            cell?.posterImage.image = movies.image
        }else{
            let movies = movieViewModel.moviesPlaying[indexPath.row]
            
            cell?.titleLabel.text = movies.title
            cell?.aboutLabel.text = movies.overview
            cell?.starsLabel.text = String(movies.voteAverage)
            cell?.starImage.image = UIImage(systemName: "star")
            cell?.posterImage.image = movies.image
        }
        
        return cell!
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}
