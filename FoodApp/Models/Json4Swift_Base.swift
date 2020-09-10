

import Foundation
struct Json4Swift_Base : Codable {
	let html_attributions : [String]?
	let results : [Results]?
	let status : String?

	enum CodingKeys: String, CodingKey {

		case html_attributions = "html_attributions"
		case results = "results"
		case status = "status"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		html_attributions = try values.decodeIfPresent([String].self, forKey: .html_attributions)
		results = try values.decodeIfPresent([Results].self, forKey: .results)
		status = try values.decodeIfPresent(String.self, forKey: .status)
	}

}
