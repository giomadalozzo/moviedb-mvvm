//
//  DetailsView.swift
//  moviedb-mvvm
//
//  Created by Luiz Eduardo Mello dos Reis on 09/03/22.
//


import UIKit


class DetailsView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var movie: Film?
    var indexPathRow: Int?
    var indexPathSection: Int?
    
    let movieViewModel = MovieTableViewModel()
    var moviesPopular = MovieTableViewModel().moviesPopular
    var moviesPlaying = MovieTableViewModel().moviesPlaying
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "mainDetails", for: indexPath) as? DetailsTableCell
        cell?.posterImage.image = movie?.image
        cell?.genresLabel.text = movie?.genres
        cell?.starsLabel.text = String(movie!.voteAverage)
            return cell!
    }
}
    
