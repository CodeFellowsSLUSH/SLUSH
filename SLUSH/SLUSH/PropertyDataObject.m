//
//  PropertyDataObject.m
//  SLUSH
//
//  Created by Stephen Lardieri on 9/22/2015.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import "PropertyDataObject.h"

#import "UserDataObject.h"


@implementation PropertyDataObject


- (CLLocationCoordinate2D) location {

  return CLLocationCoordinate2DMake(self.latitude, self.longitude);

}


+ (PropertyDataObject *) generateTestPropertyForLandlord: (UserDataObject *) landlord {

  static const CLLocationDegrees latitudeOfCodeFellows = 47.62354;
  static const CLLocationDegrees longitudeOfCodeFellows = -122.3362;

  NSArray * headlines = @[ @"Charming duplex!", @"Cute condo!", @"Hip loft!", @"Spacious house!" ];
  NSArray * descriptions = @[ @"Active living downtown", @"Quiet neighborhood, good schools", @"Full-service amenities", @"Huge back yard" ];

  
  PropertyDataObject * property = [[PropertyDataObject alloc] init];

  property.objectId = [NSString stringWithFormat: @"%8.8u", arc4random_uniform(100000000)];

  property.landlordId = landlord.objectId;

  property.headline = [headlines objectAtIndex: arc4random_uniform((unsigned int)headlines.count)];
  property.propertyDescription = [descriptions objectAtIndex: arc4random_uniform((unsigned int)descriptions.count)];

  property.price = arc4random_uniform(20) * 50 + 700;
  property.monthsAvailable = arc4random_uniform(11) + 1;

  property.numberOfBedrooms = arc4random_uniform(5) + 1;
  property.numberOfBathrooms = arc4random_uniform(3) + 1;
  property.squareFeet = arc4random_uniform(15) * 100 + 600;

  property.allowsPets = arc4random_uniform(2) > 0 ? true : false;
  property.allowsSmoking = arc4random_uniform(2) > 0 ? true : false;
  property.hasWasherDryer = arc4random_uniform(2) > 0 ? true : false;

  property.latitude = latitudeOfCodeFellows + ( 0.005 - (double)arc4random_uniform(100) / 10000.0);
  property.longitude = longitudeOfCodeFellows + ( 0.005 - (double)arc4random_uniform(100) / 10000.0);

  property.streetAddress = [NSString stringWithFormat: @"%u Boren Ave N", arc4random_uniform(20) + 490];
  property.unitNumber = [NSString stringWithFormat: @"%u", arc4random_uniform(20) + 1];
  property.city = @"Seattle";
  property.state = @"WA";
  property.zipCode = @"98123";


  return property;

}

@end
