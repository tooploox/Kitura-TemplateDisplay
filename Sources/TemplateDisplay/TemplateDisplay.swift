//
//  TemplateDisplay.swift
//  
//
//  Created by Jeremi Kaczmarczyk on 05.07.2016.
//
//

import Foundation
import Kitura
import HeliumLogger
import LoggerAPI

import Mustache

public struct TemplateDisplay {
    
    let response: RouterResponse
    
    public init(response: RouterResponse) {
        self.response = response
    }
    
    public func show(withPathString path: String, context: [String: String]) {
        guard let url = NSURL(string: path) else {
//            let templateFile = NSData(contentsOf: url),
//            let templateString = String(data: templateFile, encoding: NSUTF8StringEncoding),
//            let template = try? Template(string: templateString),
//            let body = try? template.render(context: Context(box: Box(dictionary: context))) else {
//                return Log.error("Failed to parse template")
            return Log.error("Failed to create url")

        }
        Log.info("\(url)")
        
        guard let templateFile = NSData(contentsOf: url) else {
            return Log.error("Failed to create data")
        }
        Log.info("\(templateFile)")

        guard let templateString = String(data: templateFile, encoding: NSUTF8StringEncoding) else {
            return Log.error("Failed to create string")
        }
        Log.info("\(templateString)")

        
        guard let template = try? Template(string: templateString) else {
            return Log.error("Failed to parse template")
        }
        Log.info("\(template)")

    
        guard let body = try? template.render(context: Context(box: Box(dictionary: context))) else {
            return Log.error("Failed to render template")
        }
        Log.info("\(body)")


        
        do {
            Log.debug("sending webpage: \(path)")
            try response.send(body.string)
        }
            
        catch {
            Log.error("Failed to send response \(error)")
        }
    }
}
