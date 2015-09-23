//
//  UserDataObject.m
//  SLUSH
//
//  Created by Stephen Lardieri on 9/22/2015.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import "UserDataObject.h"


@implementation UserDataObject


+ (UserDataObject *) generateTestUser {

  NSArray * firstNames = @[ @"Chris", @"Stephen", @"Ben", @"Mark" ];
  NSArray * lastNames = @[ @"Budro", @"Lardieri", @"Laddin", @"Lin" ];

  UserDataObject * user = [[UserDataObject alloc] init];

  user.objectId = [NSString stringWithFormat: @"%8.8u", arc4random_uniform(100000000)];

  NSString * firstName = [firstNames objectAtIndex: arc4random_uniform((unsigned int)firstNames.count)];
  NSString * lastName = [lastNames objectAtIndex: arc4random_uniform((unsigned int)lastNames.count)];
  user.name = [NSString stringWithFormat: @"%@ %@", firstName, lastName];

  user.emailAddress = [NSString stringWithFormat: @"%@.%@@codefellows.com", firstName, lastName];

  user.phoneNumber = [NSString stringWithFormat: @"%3.3u-%3.3u-%4.4u", arc4random_uniform(800)+200, arc4random_uniform(1000), arc4random_uniform(10000)];
  
  return user;

}


@end
