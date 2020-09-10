
import Foundation
struct Plus_code : Codable {
	let compound_code : String?
	let global_code : String?

	enum CodingKeys: String, CodingKey {

		case compound_code = "compound_code"
		case global_code = "global_code"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		compound_code = try values.decodeIfPresent(String.self, forKey: .compound_code)
		global_code = try values.decodeIfPresent(String.self, forKey: .global_code)
	}

}
