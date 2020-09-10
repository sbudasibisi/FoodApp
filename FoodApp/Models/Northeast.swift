

import Foundation
struct Northeast : Codable {
	let lat : Double?
	let lng : Double?

	enum CodingKeys: String, CodingKey {

		case lat = "lat"
		case lng = "lng"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		lat = try values.decodeIfPresent(Double.self, forKey: .lat)
		lng = try values.decodeIfPresent(Double.self, forKey: .lng)
	}

}
