

import Foundation
struct Geometry : Codable {
	let location : Location?
	let viewport : Viewport?

	enum CodingKeys: String, CodingKey {

		case location = "location"
		case viewport = "viewport"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		location = try values.decodeIfPresent(Location.self, forKey: .location)
		viewport = try values.decodeIfPresent(Viewport.self, forKey: .viewport)
	}

}
