

import Foundation
struct Results : Codable {
	let business_status : String?
	let geometry : Geometry?
	let icon : String?
	let name : String?
	let opening_hours : Opening_hours?
	let photos : [Photos]?
	let place_id : String?
	let plus_code : Plus_code?
	let price_level : Int?
	let rating : Double?
	let reference : String?
	let scope : String?
	let types : [String]?
	let user_ratings_total : Int?
	let vicinity : String?

	enum CodingKeys: String, CodingKey {

		case business_status = "business_status"
		case geometry = "geometry"
		case icon = "icon"
		case name = "name"
		case opening_hours = "opening_hours"
		case photos = "photos"
		case place_id = "place_id"
		case plus_code = "plus_code"
		case price_level = "price_level"
		case rating = "rating"
		case reference = "reference"
		case scope = "scope"
		case types = "types"
		case user_ratings_total = "user_ratings_total"
		case vicinity = "vicinity"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		business_status = try values.decodeIfPresent(String.self, forKey: .business_status)
		geometry = try values.decodeIfPresent(Geometry.self, forKey: .geometry)
		icon = try values.decodeIfPresent(String.self, forKey: .icon)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		opening_hours = try values.decodeIfPresent(Opening_hours.self, forKey: .opening_hours)
		photos = try values.decodeIfPresent([Photos].self, forKey: .photos)
		place_id = try values.decodeIfPresent(String.self, forKey: .place_id)
		plus_code = try values.decodeIfPresent(Plus_code.self, forKey: .plus_code)
		price_level = try values.decodeIfPresent(Int.self, forKey: .price_level)
		rating = try values.decodeIfPresent(Double.self, forKey: .rating)
		reference = try values.decodeIfPresent(String.self, forKey: .reference)
		scope = try values.decodeIfPresent(String.self, forKey: .scope)
		types = try values.decodeIfPresent([String].self, forKey: .types)
		user_ratings_total = try values.decodeIfPresent(Int.self, forKey: .user_ratings_total)
		vicinity = try values.decodeIfPresent(String.self, forKey: .vicinity)
	}

}
