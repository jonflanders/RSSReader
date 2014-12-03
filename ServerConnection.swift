//
//  ServerConnection.swift
//
//
//  Created by Jon Flanders on 8/22/14.
//  Copyright (c) 2014 Flounderware. All rights reserved.
//

import Foundation

typealias JsonDictionary = Dictionary<String,AnyObject>?
typealias ServerCallback = (JsonDictionary,NSError?)->(Void)
typealias ServerRawCallback = (NSData?,NSError?)->Void
class ServerConnectionManager {
    let maxOp = 100;
    init()
    {
        self.queue = NSOperationQueue()
        self.queue.maxConcurrentOperationCount = maxOp
        self.configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
    }
    private let queue:NSOperationQueue
    private let configuration:NSURLSessionConfiguration
    func get(resourceURL: String, callback: ServerRawCallback) {
        
        let url = NSURL(string: resourceURL)
        let request = NSMutableURLRequest(URL: url!)
        let session = self.getSession()
        let task = session.dataTaskWithRequest(request) { (data , response ,  err) -> Void in
          
            if(err != nil){
                
               callback(nil,err)
                
            }else
            {
				callback(data,nil)
			}
        }
        task.resume()
        
    }
    private func dictionaryFromData(data:NSData)->(JsonDictionary,NSErrorPointer){
        var err:NSErrorPointer = nil
        var ret = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: err) as JsonDictionary
        return (ret,err)
    }
    private func getSession()->NSURLSession{
        let ret = NSURLSession(configuration: configuration)
        return ret
    }
}