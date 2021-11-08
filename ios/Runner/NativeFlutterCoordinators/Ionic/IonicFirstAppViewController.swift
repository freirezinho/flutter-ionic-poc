//
//  IonicFirstAppViewController.swift
//  Runner
//
//  Created by Saulo Santos Freire on 04/11/21.
//

import Foundation
import UIKit
import ionicAppOne
import os.log

class IonicFirstAppViewController:MainViewController {
    var coordinatorDelegate: IonicCoordinatorDelegate?
    
    func goToFlutter(_ sender: Any){
        coordinatorDelegate?.navigateToFlutter()
    }
    
    override func configFilePath() -> String {
        var path = self.configFile ?? "config.xml";
        if (!NSString(string: path).isAbsolutePath) {
            let podBundle = Bundle(for: MainViewController.self)
            let resourceURL = podBundle.resourceURL?.appendingPathComponent("ionicAppOne.bundle")
            let resourceBundle = Bundle(url: resourceURL!)
            
            guard let absolutePath = resourceBundle!.path(forResource: path, ofType: nil) else {
                assertionFailure("\(path) not found in the pod bundle!")
                return ""
            }
            path = absolutePath
        }
        
        if(!FileManager.default.fileExists(atPath: path)) {
            assertionFailure("\(path) does not exist. Please run cordova-ios/bin/cordova_plist_to_config_xml path/to/project.")
            return ""
        }
        
        return path
    }
//    MARK: -TODO: Entender o que vem no "pluginsMap"
    
//    override func getCommandInstance(_ pluginName: String!) -> Any! {
//        // first, we try to find the pluginName in the pluginsMap
//            // (acts as a allowList as well) if it does not exist, we return nil
//            // NOTE: plugin names are matched as lowercase to avoid problems - however, a
//            // possible issue is there can be duplicates possible if you had:
//            // "org.apache.cordova.Foo" and "org.apache.cordova.foo" - only the lower-cased entry will match
////            NSString* className = [self.pluginsMap objectForKey:[pluginName lowercaseString]];
////
//        let className: NSString = NSString(string: self.pluginsMap[pluginName.lowercased()] as! String)
//
//        var obj = self.pluginObjects[className]
//        if (obj == nil) {
//            obj = NSClassFromString(className as String)
//            let podBundle = Bundle(for: MainViewController.self)
//            let resourceURL = podBundle.resourceURL?.appendingPathComponent("ionicAppOne.bundle")
//            let resourceBundle = Bundle(url: resourceURL!)
//            
//            var fullClassName = NSString(string: "\(resourceBundle!.infoDictionary!["CFBundleExecutable"]!).\(className)")
//            
//            if (obj != nil) {
//                self.register(obj as? CDVPlugin, withClassName: className as String);
//            } else {
//                print("CDVPlugin class \(className) (pluginName: \(pluginName) does not exist.")
//            }
//        }
//        return obj
////            if (className == nil) {
////                return nil;
////            }
////
////            id obj = [self.pluginObjects objectForKey:className];
////            if (!obj) {
////                obj = [[NSClassFromString(className)alloc] initWithWebViewEngine:_webViewEngine];
////                if (!obj) {
////                    NSString* fullClassName = [NSString stringWithFormat:@"%@.%@",
////                                               NSBundle.mainBundle.infoDictionary[@"CFBundleExecutable"],
////                                               className];
////                    obj = [[NSClassFromString(fullClassName)alloc] initWithWebViewEngine:_webViewEngine];
////                }
////
////                if (obj != nil) {
////                    [self registerPlugin:obj withClassName:className];
////                } else {
////                    NSLog(@"CDVPlugin class %@ (pluginName: %@) does not exist.", className, pluginName);
////                }
////            }
////            return obj;
//    }
    
    func pathForResource(forResource resourcepath: String) -> String? {
//        let podBundle = Bundle(for: MainViewController.self)
//        let resourceURL = podBundle.resourceURL?.appendingPathComponent("ionicAppOne.bundle")
//        let resourceBundle = Bundle(url: resourceURL!)
//
//        guard let absolutePath = resourceBundle!.path(forResource: path, ofType: nil) else {
//            assertionFailure("\(path) not found in the pod bundle!")
//            return nil
//        }
//        path = absolutePath
        
//        NSBundle* mainBundle = [NSBundle mainBundle];
        // Setup variables
        var classForBundle: AnyClass? = nil
        classForBundle = MainViewController.self
        
        let bundleFullName: String = "ionicAppOne.bundle"
        // Could be substituted in delegate
        let folderName = self.wwwFolderName
        
        let bundleForClass: Bundle = Bundle(for: classForBundle!.self)
        let resourceURL = bundleForClass.resourceURL?.appendingPathComponent(bundleFullName)
        let resourceBundle = Bundle(url: resourceURL!)
//        NSMutableArray* directoryParts = [NSMutableArray arrayWithArray:[resourcepath componentsSeparatedByString:@"/"]];
        var directoryParts: [String] = resourcepath.components(separatedBy: "/")
//        NSString* filename = [directoryParts lastObject];
        let filename = directoryParts.last

//
//        [directoryParts removeLastObject];
        directoryParts.removeLast()
//
//        NSString* directoryPartsJoined = [directoryParts componentsJoinedByString:@"/"];
        let directoryPartsJoined = directoryParts.joined(separator: "/")
//        NSString* directoryStr = _viewController.wwwFolderName;
        var directoryString = folderName
//
//        if ([directoryPartsJoined length] > 0) {
//            directoryStr = [NSString stringWithFormat:@"%@/%@", _viewController.wwwFolderName, [directoryParts componentsJoinedByString:@"/"]];
//        }
        if (directoryPartsJoined.count > 0) {
            directoryString = "\(folderName!)/\(directoryParts.joined(separator: "/"))"
        }
//
//        return [mainBundle pathForResource:filename ofType:@"" inDirectory:directoryStr];
        return resourceBundle?.path(forResource: filename, ofType: "", inDirectory: directoryString)
    }
    
    override func appUrl() -> URL? {
        var appURL: URL? = nil;
        if (NSString(string: self.startPage).range(of: "://").location != NSNotFound) {
            appURL = URL(string: self.startPage)
        } else if (NSString(string: self.wwwFolderName).range(of: "://").location != NSNotFound) {
            appURL = URL(string: "\(self.wwwFolderName!)/\(self.startPage!)");
        } else {
            let startURL = URL(string: self.startPage)
            let newCommandDelegate = CDVCustomCommandDelegate(viewController: self)
            newCommandDelegate!.classInBundle = MainViewController.self
            self.setCommandDelegate(newCommandDelegate!)
            let startFilePath = self.commandDelegate.path(forResource: startURL!.path)
//            let startFilePath = self.pathForResource(forResource: startURL!.path)
            if let startPath = startFilePath {
                appURL = URL(fileURLWithPath: startPath)
                let startPageNoParentDirs = NSString(string: self.startPage)
                let range = startPageNoParentDirs.rangeOfCharacter(from: CharacterSet(charactersIn: "?"), options: .caseInsensitive)
                if(range.location != NSNotFound) {
                    let queryOrFragment = NSString(string: self.startPage).substring(from: range.location)
                    appURL = URL(string: queryOrFragment, relativeTo: appURL)
                }
            } else {
                appURL = nil
            }
        }
        return appURL
    }
}
