//
//  PropertyDataObject.m
//  SLUSH
//
//  Created by Stephen Lardieri on 9/22/2015.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import "PropertyDataObject.h"


@implementation PropertyDataObject


- (CLLocationCoordinate2D) location {

  return CLLocationCoordinate2DMake(self.latitude, self.longitude);

}


@end
