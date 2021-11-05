//
//  CDVCommandDelegateImpl+CDVViewController.m
//  Runner
//
//  Created by Saulo Santos Freire on 05/11/21.
//
#import <Cordova/Cordova.h>
#import "CDVCommandDelegateImpl+CDVViewController.h"
#import <objc/runtime.h>


@implementation CDVCommandDelegateImpl (IonicIntegration)
- (CDVViewController*) viewController {
//    return _viewController;
    NSString const *key = @"_viewController";

    return objc_getAssociatedObject(self,(__bridge const void * _Nonnull)(key));
}
@end

