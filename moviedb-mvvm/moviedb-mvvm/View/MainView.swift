//
//  ViewController.swift
//  moviedb-mvvm
//
//  Created by Giovanni Madalozzo on 04/03/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var movieTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTable.delegate = self
        movieTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 2
        }else{
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}
