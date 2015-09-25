//
//  ParseService.h
//  SLUSH
//
//  Created by Chris Budro on 9/23/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@class Property;
@class PropertyQueryFilter;
@class User;

@interface ParseService : NSObject

+ (void)propertiesWithFilter:(PropertyQueryFilter *)filter completionHandler:(void (^)(NSArray *properties, NSError *))handler;
+ (void)fetchImageObject:(PFObject *)imageObject withBlock:(void(^)(UIImage *image, NSError *error))handler;
+ (void)fetchUserObjectWithId:(NSString *)userObjectId withBlock:(void(^)(User *user, NSError *error))handler;

@end
