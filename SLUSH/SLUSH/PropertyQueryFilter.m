//
//  PropertyQueryFilter.m
//  SLUSH
//
//  Created by Stephen Lardieri on 9/22/2015.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import "PropertyQueryFilter.h"

@implementation PropertyQueryFilter

-(void)setMinPrice:(NSNumber *)minPrice {
  _minPrice = minPrice;
  _minPricePredicate = [NSPredicate predicateWithFormat:@"minPrice = %@", minPrice];
}

- (NSString *) asSQLQuery {

  return @"WHERE 1 == 1";
  
}


@end
