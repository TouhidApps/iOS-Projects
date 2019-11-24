import Foundation

public struct Result : Codable {
	let id : String?
	let name : String?
	let phone : String?
	let email : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case phone = "phone"
		case email = "email"
	}

	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		phone = try values.decodeIfPresent(String.self, forKey: .phone)
		email = try values.decodeIfPresent(String.self, forKey: .email)
	}

}
