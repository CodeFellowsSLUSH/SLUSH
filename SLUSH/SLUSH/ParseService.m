//
//  ParseService.m
//  SLUSH
//
//  Created by Chris Budro on 9/23/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import "ParseService.h"
#import "PropertyQueryFilter.h"
#import <Parse/Parse.h>
#import "Property.h"

@implementation ParseService

- (void)propertiesWithFilter:(PropertyQueryFilter *)filter completionHandler:(void (^)(NSArray *properties, NSError *))handler {
  PFQuery *query = [Property query];
  
}



@end
