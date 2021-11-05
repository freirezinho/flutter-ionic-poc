//
//  CDVViewController+IonicIntegration.h
//  Runner
//
//  Created by Saulo Santos Freire on 05/11/21.
//

#import <Cordova/Cordova.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDVViewController (IonicIntegration)
- (NSString*)configFilePath;
- (NSURL*)appUrl;
@end

@interface CDVViewController (IonicIntegrationExtension)
- (void)setCommandDelegate:(CDVCommandDelegateImpl*)delegate;
@end

NS_ASSUME_NONNULL_END
