//
//  MeetupAPIClient.swift
//  MeetupSecondProject
//
//  Created by Flatiron School on 1/29/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import Foundation

class MeetupAPIClient{

    class func getMeetupEvents(zipCode: String, topic: String, completion:@escaping(Array<Any>)->()){
        
        var jsonArrayOfDictionary : Array<Any> = []
        
        let meetupURL = "https://api.meetup.com/2/open_events.json?topic=\(topic)&zip=\(zipCode)&time=,1w&key=\(Secrets.meetupAPIKey)"
        
        let convertedString = URL(string: meetupURL)
        
        guard let unwrappedConvertedString = convertedString else {print("convertedString did not unwrap"); return}
        
        let request = URLRequest(url: unwrappedConvertedString)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let unwrappedData = data else {print("jsonData did not unwrap"); return}
            
            let jsonResponse = try? JSONSerialization.jsonObject(with: unwrappedData, options: []) as! [String: Any]
            
            guard let unwrappedJsonResponse = jsonResponse else {print("jsonResponse did not unwrap"); return}
            
            guard let unwrappedResultsArray = unwrappedJsonResponse["results"] as? Array<Any> else {print("resultsArray did not unwarp"); return}
            
            jsonArrayOfDictionary = unwrappedResultsArray
            
            completion(jsonArrayOfDictionary)
        
        }
            task.resume()
    }

}
