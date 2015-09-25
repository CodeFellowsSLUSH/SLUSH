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

@interface ParseService : NSObject

+ (void)propertiesWithFilter:(PropertyQueryFilter *)filter completionHandler:(void (^)(NSArray *properties, NSError *))handler;
+ (void)fetchImageObject:(PFObject *)imageObject withBlock:(void(^)(UIImage *image, NSError *error))handler;

@end
