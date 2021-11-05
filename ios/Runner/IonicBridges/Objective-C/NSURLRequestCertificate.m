//
//  NSURLRequestCertificate.m
//  Runner
//
//  Created by Saulo Santos Freire on 05/11/21.
//

#import <Foundation/Foundation.h>

@implementation NSURLRequest(DataController)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host{
  return YES;
}
@end
