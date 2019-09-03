//
//  PersonTableViewCell.swift
//  FindACrew
//
//  Created by Percy Ngan on 9/3/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
import UIKit

class PersonTableViewCell: UITableViewCell {

	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var ageLabel: UILabel!
	@IBOutlet weak var hairColorLabel: UILabel!

	var person: Person? {
		didSet {
			updateViews()
		}
	}

	func updateViews() {
		guard let person = person else { return }

		nameLabel.text = person.name
		ageLabel.text = person.birthYear
		hairColorLabel.text = "Hair color: \(person.hairColor)"
	}
}
