//
//  AboutConstants.swift
//  WeatherAppInterns
//
//  Created by Gerardo Leal on 24/05/23.
//

import Foundation

enum AboutConstants: String {
    case visibility = "Visibility tells you how far away you can clearly see objects like buildings and hills. It is a measure of the transparency of the air and does not take into account the amount of sunlight or the presence of obstructions. Visibility at or above 10 km is considered clear."
    case uvIndex = "The World Health Organization's UV index (UVI) measures ultraviolet radiation. The higher the UVI, the greater the potential for damage, and the faster harm can occur. The UVI can help you decide when to protect yourself from the sun and when to avoid being outside. The WHO recommends using shade, sunscreen, hats, and protective clothing at levels of 3 (Moderate) or higher."
    case wind = "The wind speed is calculated using the average over a short period of time. Gusts are short bursts of wind above this average. A gust typically lasts under 20 seconds."
    case feelsLike = "Feels Like conveys how warm or cold it feels and can be different from the actual temperature. The Feels Like temperature is affected by humidity and wind"
    case humidity = "Relative humidity, commonly known just as humidity, is the amount of moisture in the air compared to what the air can hold. The air can hold more moisture at higher temperatures. A relative humidity near 100% means there may be dew or fog"
    case dewPoint = "The dew point is what the temperature would need to fall to for dew to form. Itt can be a useful way to tell how humid the air feels - the higher the dew point, the more humid it feels. A dew point that matches the current temperature means the relative humidity is 100%, and there may be dew or fog"
    case pressure = "Signifcant, rapid changes in pressure are used to predict changes in the weather. For example, a drop in pressure can mean that rain or snow is on the way, and rising pressure can mean that weather will improve. Pressure is also called barometric pressure or atmospheric pressure."
    case airQuality = "PM2.5 particles are small enough to enter the bloodstream and tipycally result from wildfires, smokestacks, bateria, or small dust particles."
}
