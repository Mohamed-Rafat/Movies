//
//	Movie.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Movie : Codable {

	let createdAt : Int?
	let descriptionField : String?
	let director : String?
	let gentres : [Gentre]?
	let id : Int?
	let mainStar : String?
	let name : String?
	let thumbnail : String?
	let updatedAt : Int?
	let year : Int?


	enum CodingKeys: String, CodingKey {
		case createdAt = "created_at"
		case descriptionField = "description"
		case director = "director"
		case gentres = "gentres"
		case id = "id"
		case mainStar = "main_star"
		case name = "name"
		case thumbnail = "thumbnail"
		case updatedAt = "updated_at"
		case year = "year"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
		descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
		director = try values.decodeIfPresent(String.self, forKey: .director)
		gentres = try values.decodeIfPresent([Gentre].self, forKey: .gentres)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		mainStar = try values.decodeIfPresent(String.self, forKey: .mainStar)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
		updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
		year = try values.decodeIfPresent(Int.self, forKey: .year)
	}


}