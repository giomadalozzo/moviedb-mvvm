//
//  ViewController.swift
//  moviedb-mvvm
//
//  Created by Giovanni Madalozzo on 04/03/22.
//

import UIKit

class MainView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var movieTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTable.delegate = self
        movieTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieTable.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath) as? MovieTableCell
        
        return cell!
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}
