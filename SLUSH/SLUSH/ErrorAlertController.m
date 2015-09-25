//
//  ErrorAlertController.m
//  SLUSH
//
//  Created by Chris Budro on 9/22/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import "ErrorAlertController.h"

@implementation ErrorAlertController

+ (UIAlertController *)alertWithError:(NSError *)error {
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
  
  [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
  
  return alert;
}

+(UIAlertController *)alertWithErrorString:(NSString *)errorString {
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:errorString preferredStyle:UIAlertControllerStyleAlert];
  
  [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
  
  return alert;
}

@end
