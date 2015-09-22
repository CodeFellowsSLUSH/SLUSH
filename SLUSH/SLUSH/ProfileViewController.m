//
//  ProfileViewController.m
//  SLUSH
//
//  Created by Benjamin Laddin on 9/21/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import "ProfileViewController.h"
#import "LoginViewController.h"
#import <AWSDynamoDB/AWSDynamoDB.h>
#import "AWSDatabaseManager.h"
#import "Property.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  // Testing save to database
  /*
  Property *newProperty = [[Property alloc] init];
  newProperty.headline = @"Charming 2BR House in Eastlake";
  newProperty.propertyDescription = @"The most beautiful house in all of Seattle";
  newProperty.price = @4000;
  newProperty.objectId = @"2";
  newProperty.zipCode = @"98102";
  
  [AWSDatabaseManager saveItem:newProperty withCompletionBlock:^(BOOL success, NSError *error) {
    if (error) {
      NSLog(@"profile view error: %@", error.localizedDescription);
    } else if (success) {
      NSLog(@"Success");
    }
  }];
  */
}

@end
