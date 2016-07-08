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

public enum TemplateDisplayError: ErrorType {
    case Parse
}

public struct MustacheTemplateDisplay: TemplateEngine {
    
    var fileExtenstion: String {
        return "mustache"
    }
    
    public static func render(filePath: String, context: [String: Any]) throws -> String {
        guard let templateData = NSData(contentsOfFile: path),
            let templateString = String(data: templateData, encoding: NSUTF8StringEncoding),
            let template = try? Template(string: templateString),
            let body = try? template.render(context: Context(box: Box(dictionary: context))) else {
                Log.error("Failed to parse template")
                throw TemplateDisplayError.Parse
        }
        return body
    }
}