//
//  User.h
//  SLUSH
//
//  Created by Stephen Lardieri on 9/22/2015.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>


@interface User : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSString * emailAddress;
@property (strong, nonatomic) NSString * phoneNumber;

@property (strong, nonatomic) NSArray * favoriteProperties;

- (void) save;

+ (User *) generateTestUser;

@end
