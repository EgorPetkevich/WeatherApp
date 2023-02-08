

import Foundation

struct WeatherResponse: Decodable {
    let queryCost: Int
    let latitude, longitude: Double
    let resolvedAddress, address, timezone: String
    let tzoffset: Int
    let days: [CurrentConditions]
    let currentConditions: CurrentConditions

    enum CodingKeys: CodingKey {
        case queryCost
        case latitude
        case longitude
        case resolvedAddress
        case address
        case timezone
        case tzoffset
        case days
        case currentConditions
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.queryCost = try container.decode(Int.self, forKey: .queryCost)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
        self.resolvedAddress = try container.decode(String.self, forKey: .resolvedAddress)
        self.address = try container.decode(String.self, forKey: .address)
        self.timezone = try container.decode(String.self, forKey: .timezone)
        self.tzoffset = try container.decode(Int.self, forKey: .tzoffset)
        self.days = try container.decode([CurrentConditions].self, forKey: .days)
        self.currentConditions = try container.decode(CurrentConditions.self, forKey: .currentConditions)
    }
    }

    


// MARK: - CurrentConditions
struct CurrentConditions: Decodable{
    let datetime: String
    let datetimeEpoch: Int?
    let temp, feelslike: Double
    let snow: Int?
    let windspeed, pressure, cloudcover: Double
    let conditions, icon: String
    let sunrise, sunset: String?
    let moonphase, tempmax, tempmin: Double?
    let description: String?
    let hours: [CurrentConditions]?
    
    
    enum CodingKeys: CodingKey {
        case datetime
        case datetimeEpoch
        case temp
        case feelslike
        case snow
        case windspeed
        case pressure
        case cloudcover
        case conditions
        case icon
        case sunrise
        case sunset
        case moonphase
        case tempmax
        case tempmin
        case description
        case hours
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.datetime = try container.decode(String.self, forKey: .datetime)
        self.datetimeEpoch = try? container.decode(Int.self, forKey: .datetimeEpoch)
        self.temp = try container.decode(Double.self, forKey: .temp)
        self.feelslike = try container.decode(Double.self, forKey: .feelslike)
        self.snow = try container.decodeIfPresent(Int.self, forKey: .snow)
        self.windspeed = try container.decode(Double.self, forKey: .windspeed)
        self.pressure = try container.decode(Double.self, forKey: .pressure)
        self.cloudcover = try container.decode(Double.self, forKey: .cloudcover)
        self.conditions = try container.decode(String.self, forKey: .conditions)
        self.icon = try container.decode(String.self, forKey: .icon)
        self.sunrise = try container.decodeIfPresent(String.self, forKey: .sunrise)
        self.sunset = try container.decodeIfPresent(String.self, forKey: .sunset)
        self.moonphase = try container.decodeIfPresent(Double.self, forKey: .moonphase)
        self.tempmax = try container.decodeIfPresent(Double.self, forKey: .tempmax)
        self.tempmin = try container.decodeIfPresent(Double.self, forKey: .tempmin)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.hours = try container.decodeIfPresent([CurrentConditions].self, forKey: .hours) 
    }
  
}
