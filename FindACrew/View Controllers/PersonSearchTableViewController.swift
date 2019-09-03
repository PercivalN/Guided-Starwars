//
//  PersonSearchTableViewController.swift
//  FindACrew
//
//  Created by Spencer Curtis on 9/3/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PersonSearchTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!

	let personController = PersonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
		searchBar.delegate = self

    }

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return personController.people.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as? PersonTableViewCell else { return UITableViewCell() }

		cell.person = personController.people[indexPath.row]

		return cell
    
}
}

extension PersonSearchTableViewController: UISearchBarDelegate {

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		// Get the text from the searchBar and perform the search function

		guard let searchTerm = searchBar.text else { return }

		personController.searchForPeople(with: searchTerm) {
			DispatchQueue.main.async {
				self.tableView.reloadData()
				
			}
		}
	}
}
