//
//  UserDataObject.h
//  SLUSH
//
//  Created by Stephen Lardieri on 9/22/2015.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDataObject : NSObject

@property (strong, nonatomic) NSString * objectId;

@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSString * emailAddress;
@property (strong, nonatomic) NSString * phoneNumber;

@property (strong, nonatomic) NSArray * favoriteProperties;


+ (UserDataObject *) generateTestUser;

@end
