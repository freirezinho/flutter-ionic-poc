//
//  CDVCommandDelegateImpl+CDVViewController.h
//  Runner
//
//  Created by Saulo Santos Freire on 05/11/21.
//

#import <Cordova/Cordova.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDVCommandDelegateImpl (IonicIntegration)
    @property (weak, nonatomic, readonly) CDVViewController* viewController;
@end

NS_ASSUME_NONNULL_END
