//
//  SwiftyCloudant.swift
//  Swifty Cloudant
//
//  Created by Matthew Smith on 2015-06-20.
//

import Foundation

class SwiftyCloudant {
    
    var username = ""
    var apiPassword = ""
    var apiKey = ""
    var database = ""
    var urlBase:String {
        return "https://\(apiKey):\(apiPassword)@\(username).cloudant.com/\(database)"
    }
    
    init(username: String, apiPassword: String, apiKey: String, database: String) {
        self.username = username
        self.apiPassword = apiPassword
        self.apiKey = apiKey
        self.database = database
    }
    
    func getAllDocuments(completion: (result: JSON) -> Void) -> Void {
        let url = urlBase + "/_all_docs?include_docs=true"
        println(url)
        var request = NSURLRequest(URL: NSURL(string: url)!)
        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        var json = JSON("")
        if data != nil {
            json = JSON(data: data!)
        }
        return completion(result: json)
    }
    
    func getDocument(id: String, completion:(result: JSON) -> Void) -> Void {
        let url = urlBase + "/" + id
        println(url)
        var request = NSURLRequest(URL: NSURL(string: url)!)
        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        var json = JSON("")
        if data != nil {
            json = JSON(data: data!)
        }
        return completion(result: json)
    }
    
    func deleteDocument(id:String, rev:String, completion:(result: JSON) -> Void) -> Void {
        let url = urlBase + "/" + id + "?rev=" + rev
        println(url)
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "DELETE"
        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        var json = JSON("")
        if data != nil {
            json = JSON(data: data!)
        }
        return completion(result: json)
    }
    
    func updateDocument(id:String, rev:String, json:JSON, completion:(result: JSON) -> Void) -> Void {
        let url = urlBase + "/" + id
        println(url)
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "PUT"
        request.HTTPBody = json.rawData()
        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        var json = JSON("")
        if data != nil {
            json = JSON(data: data!)
        }
        return completion(result: json)
    }
    
    func createDocument(json:JSON, completion:(result: JSON) -> Void) -> Void {
        let url = urlBase
        println(url)
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = json.rawData()
        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        var json = JSON("")
        if data != nil {
            json = JSON(data: data!)
        }
        return completion(result: json)
    }
    
    func searchIndex(designDocument:String, indexName:String, luceneQuery:String, completion:(result: JSON) -> Void) -> Void {
        let url = urlBase + "/_design/" + designDocument + "/_search/" + indexName + "?q=" + luceneQuery + "&include_docs=true"
        println(url)
        var request = NSURLRequest(URL: NSURL(string: url)!)
        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        var json = JSON("")
        if data != nil {
            json = JSON(data: data!)
        }
        return completion(result: json)
    }
    
}