//
//	PersonController.swift
//  FindACrew
//
//  Created by Percy Ngan on 9/3/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class PersonController {

	let baseURL = URL(string: "https://swapi.co/api/")!

	var people: [Person] = []
	// CRUD

	// Look up escaping function in Swift language guide
	// The goal is to update the people array and then call completion(), notifying the view controller that we have finished fetching the searched people.
	func searchForPeople(with searchTerm: String, completion: @escaping () -> Void) {

		let peopleURL = baseURL.appendingPathComponent("people") // https://swapi.co/api/people/

		var components = URLComponents(url: peopleURL, resolvingAgainstBaseURL: true)

		let searchItem = URLQueryItem(name: "search", value: searchTerm)

		components?.queryItems = [searchItem]

		// Ask the component to give us the formatted URL from the parts we gave it
		guard let requestURL = components?.url else {
			completion()
			return
		}

		// https://swapi.co/api/people/?search=luke

		var request = URLRequest(url: requestURL)
		// This httpMethod is just asking us for a string and the enum is used for the autocomplete
		request.httpMethod = HTTPMethod.get.rawValue

		// The data task hasn't gone to the API yet
		URLSession.shared.dataTask(with: request) { (data, _, error) in

			// The data task has gone to the API and come back with the data, response and error from the API.

			// Check for an error

			if let error = error {
				// This is error handling which includes the error, and also the line location and file
				// NSLog and print statements use the same syntax, but NSLog does a lot more
				print("Error searching for people: \(error), on \(#line) in \(#file)")
			}

			// See if there is data

			guard let data = data else {
				NSLog("No data returned from searching for people")
				completion()
				return
			}

			// Decode the data

			do {
				let decoder = JSONDecoder()

				let personSearch = try decoder.decode(PersonSearch.self, from: data)

				self.people = personSearch.results
			} catch {
				NSLog("Error decoding PersonSearch from data: \(error)")
			}

			completion()

			}.resume()
	}

	// Using enum in this situation to get the autocomplete feature to ensure that there are less typos
	enum HTTPMethod: String {
		case get = "GET"
		case put = "PUT"
		case post = "POST"
		case delete = "DELETE"
	}
}
