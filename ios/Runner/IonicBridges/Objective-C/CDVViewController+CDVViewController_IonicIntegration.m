//
//  CDVViewController+CDVViewController_IonicIntegration.m
//  Runner
//
//  Created by Saulo Santos Freire on 05/11/21.
//

#import "CDVViewController+IonicIntegration.h"

@implementation CDVViewController (IonicIntegrationExtension)

- (void)setCommandDelegate:(CDVCommandDelegateImpl*)delegate
{
    _commandDelegate = delegate;
}
@end
