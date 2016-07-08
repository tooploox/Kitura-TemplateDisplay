//
//  TemplateDisplay.swift
//  
//
//  Created by Jeremi Kaczmarczyk on 05.07.2016.
//
//

import Foundation
import Kitura
import KituraTemplateEngine
import HeliumLogger
import LoggerAPI

import Mustache

public struct MustacheTemplateDisplay: TemplateEngine {
    
    var fileExtenstion: String {
        return "mustache"
    }
    
    public func render(filePath: String, context: [String: Any]) throws -> String {
        guard let templateData = NSData(contentsOfFile: filePath),
            let templateString = String(data: templateData, encoding: NSUTF8StringEncoding),
            let template = try? Template(string: templateString),
            let boxContext = context as? [String: String],
            let body = try? template.render(context: Context(box: Box(dictionary: boxContext))) else {
                Log.error("Failed to parse template")
                throw NSError()
        }
        return body.string
    }
}