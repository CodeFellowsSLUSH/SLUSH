//
//  Property.h
//  SLUSH
//
//  Created by Chris Budro on 9/21/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMaps/GoogleMaps.h>
#import <AWSDynamoDB/AWSDynamoDB.h>
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>

@interface Property : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *headline;
@property (strong, nonatomic) NSString *propertyDescription;
@property (strong, nonatomic) NSNumber *numberOfBedrooms;
@property (strong, nonatomic) NSNumber *numberOfBathrooms;
@property (nonatomic) BOOL allowsPets;
@property (strong, nonatomic) NSArray *photos;
@property (strong, nonatomic) NSNumber *price;
@property (strong, nonatomic) NSString *streetAddress;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *unitNumber;
@property (strong, nonatomic) NSString *zipCode;

@property (strong, nonatomic) GMSPlace *placeDetails;



@end
