//
//  User.m
//  SLUSH
//
//  Created by Stephen Lardieri on 9/22/2015.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import "User.h"


@implementation User

@dynamic name;
@dynamic phoneNumber;

@dynamic favoriteProperties;


- (void) save {

  if (self.isDirty) {
    [self saveEventually];
  }

}


+ (User *) generateTestUser {

  NSArray * firstNames = @[ @"Chris", @"Stephen", @"Ben", @"Mark" ];
  NSArray * lastNames = @[ @"Budro", @"Lardieri", @"Laddin", @"Lin" ];

  // TODO: username and password
  // This code worked before we subclassed PFUser - unknown whether it still works.
  User * user = [User object];

  NSString * firstName = [firstNames objectAtIndex: arc4random_uniform((unsigned int)firstNames.count)];
  NSString * lastName = [lastNames objectAtIndex: arc4random_uniform((unsigned int)lastNames.count)];
  user.name = [NSString stringWithFormat: @"%@ %@", firstName, lastName];

  user.email = [NSString stringWithFormat: @"%@.%@@codefellows.com", firstName, lastName];

  user.phoneNumber = [NSString stringWithFormat: @"%3.3u-%3.3u-%4.4u", arc4random_uniform(800)+200, arc4random_uniform(1000), arc4random_uniform(10000)];
  
  return user;

}


@end
