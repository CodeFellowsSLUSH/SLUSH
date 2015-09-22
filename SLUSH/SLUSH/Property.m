//
//  Property.m
//  SLUSH
//
//  Created by Chris Budro on 9/21/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import "Property.h"

@implementation Property

+ (NSString *)dynamoDBTableName {
  return @"Properties";
}

+ (NSString *)hashKeyAttribute {
  return @"headline";
}

+ (NSString *)rangeKeyAttribute {
  return @"propertyDescription";
}

@end
