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
import File

struct TemplateDisplay {
    
    let response: RouterResponse
    
    func show(withPathString path: String, context: [String: String]) {
        guard let templateFile = try? File(path: path),
            let templateString = try? String(data: templateFile.readAllBytes()),
            let template = try? Template(string: templateString),
            let body = try? template.render(context: Context(box: Box(dictionary: context))) else {
                return Log.error("Failed to parse template")
        }
        
        do {
            Log.debug("sending webpage: \(path)")
            try response.send(body.string)
        }
            
        catch {
            Log.error("Failed to send response \(error)")
        }
    }
}
