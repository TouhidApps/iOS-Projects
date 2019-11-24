import Foundation

public struct UserModel : Codable {
	public let result : [Result]?

	enum CodingKeys: String, CodingKey {
		case result = "result"
	}

	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		result = try values.decodeIfPresent([Result].self, forKey: .result)
	}

}
