//
//	User.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct User : Codable {

	let createdAt : Int?
	let id : Int?
	let updatedAt : Int?
	let username : String?


	enum CodingKeys: String, CodingKey {
		case createdAt = "created_at"
		case id = "id"
		case updatedAt = "updated_at"
		case username = "username"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
		username = try values.decodeIfPresent(String.self, forKey: .username)
	}


}