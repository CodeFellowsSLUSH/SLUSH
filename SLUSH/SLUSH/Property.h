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

@interface Property : AWSDynamoDBObjectModel <AWSDynamoDBModeling>

@property (strong, nonatomic) NSString *headline;
@property (strong, nonatomic) NSString *propertyDescription;
@property (nonatomic) NSInteger numberOfBedrooms;
@property (nonatomic) NSInteger numberOfBathrooms;
@property (nonatomic) BOOL allowsPets;
@property (strong, nonatomic) NSArray *photos;
@property (strong, nonatomic) NSNumber *price;
@property (strong, nonatomic) GMSPlace *placeDetails;
@property (strong, nonatomic) NSString *streetAddress;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *unitNumber;
@property (strong, nonatomic) NSString *zipCode;
@property (strong, nonatomic) NSString *objectId;
@property (strong, nonatomic) GMSMarker *marker;

@end
