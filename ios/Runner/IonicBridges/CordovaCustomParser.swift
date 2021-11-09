//
//  CordovaCustomParser.swift
//  Runner
//
//  Created by Saulo on 09/11/21.
//

import Foundation
import Cordova

class CDVCustomConfigParser: CDVConfigParser {
    
    var featureName: String?
    
    override func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if (elementName == "preference") {
            settings[attributeDict["name"]!.lowercased()] = attributeDict["value"]
        }
        else if (elementName == "feature") {
            featureName = attributeDict["name"]!.lowercased()
        }
        else if (featureName != nil && elementName == "param") {
            var paramName = attributeDict["name"]!.lowercased()
            var value = attributeDict["value"]
            if (paramName == "ios-package") {
                pluginsDict[featureName] = value
            }
            var paramIsOnLoad = paramName == "onload" && value == "true" ? true : false
            var attribIsOnload = attributeDict["onload"]!.lowercased() == "true" ? true : false
            if (paramIsOnLoad || attribIsOnload) {
                self.startupPluginNames.add(featureName)
            }
        }
        else if (elementName == "plugin") {
            
        }
    }
}
