

import Foundation
struct Opening_hours : Codable {
	let open_now : Bool?

	enum CodingKeys: String, CodingKey {

		case open_now = "open_now"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		open_now = try values.decodeIfPresent(Bool.self, forKey: .open_now)
	}

}
