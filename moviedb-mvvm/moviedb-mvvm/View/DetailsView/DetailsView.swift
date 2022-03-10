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
    var genres: [Genres] = []
    var stringGenres: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
            }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "mainDetails", for: indexPath) as? DetailsTableCell
            
            
            return UITableViewCell()
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "overview", for: indexPath) as? DetailsOverviewCell
            cell?.titleLabel.text = "Overview"
            cell?.titleLabel.text = self.movie?.overview
            cell?.titleLabel.numberOfLines = 0
            cell?.titleLabel.lineBreakMode = .byWordWrapping
            
            return cell!
        }
    }
    
    func generateGenresString(genres: [Int]) -> String {
        var string: String = ""
        
        for genreID in genres{
            for genre in self.genres{
                if genre.id == genreID {
                    string = string + genre.genre + ", "
                }
            }
        }
        let stringOutput = String(string.dropLast().dropLast())
        
        return stringOutput
    }

    
    
    
    
}
    
