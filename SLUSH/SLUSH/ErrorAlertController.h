//
//  ErrorAlertController.h
//  SLUSH
//
//  Created by Chris Budro on 9/22/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ErrorAlertController : NSObject

+ (UIAlertController *)alertWithError:(NSError *)error;
+(UIAlertController *)alertWithErrorString:(NSString *)errorString;

@end
