//
//  Person.swift
//  FindACrew
//
//  Created by Percy Ngan on 9/3/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//



import Foundation

struct PersonSearch: Codable {
	let results: [Person]
}

struct Person: Codable {

	// CodingKeys allows Codable to map properties that don't have matching names to the JSON
	enum CodingKeys: String, CodingKey {
		case name
		case birthYear = "birth_year"
		case hairColor = "hair_color"
	}

	let name: String
	let birthYear: String
	let hairColor: String
}

