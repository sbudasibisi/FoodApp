

import Foundation
struct Photos : Codable {
	let height : Int?
	let html_attributions : [String]?
	let photo_reference : String?
	let width : Int?

	enum CodingKeys: String, CodingKey {

		case height = "height"
		case html_attributions = "html_attributions"
		case photo_reference = "photo_reference"
		case width = "width"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		height = try values.decodeIfPresent(Int.self, forKey: .height)
		html_attributions = try values.decodeIfPresent([String].self, forKey: .html_attributions)
		photo_reference = try values.decodeIfPresent(String.self, forKey: .photo_reference)
		width = try values.decodeIfPresent(Int.self, forKey: .width)
	}

}
