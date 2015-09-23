//
//  PropertyDataObject.h
//  SLUSH
//
//  Created by Stephen Lardieri on 9/22/2015.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@class UserDataObject;


@interface PropertyDataObject : NSObject

@property (strong, nonatomic) NSString * objectId;
@property (strong, nonatomic) NSString * landlordId;

@property (nonatomic, strong) NSString * headline;
@property (nonatomic, strong) NSString * propertyDescription;

@property (nonatomic) NSInteger price;
@property (nonatomic) NSInteger monthsAvailable;

@property (nonatomic) NSInteger numberOfBedrooms;
@property (nonatomic) NSInteger numberOfBathrooms;
@property (nonatomic) NSInteger squareFeet;

@property (nonatomic) BOOL allowsSmoking;
@property (nonatomic) BOOL allowsPets;
@property (nonatomic) BOOL hasWasherDryer;

@property (strong, nonatomic) NSArray * photos;

@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (readonly, nonatomic) CLLocationCoordinate2D location;

@property (strong, nonatomic) NSString * streetAddress;
@property (strong, nonatomic) NSString * unitNumber;
@property (strong, nonatomic) NSString * city;
@property (strong, nonatomic) NSString * state;
@property (strong, nonatomic) NSString * zipCode;


+ (PropertyDataObject *) generateTestPropertyForLandlord: (UserDataObject *) landlord;

@end
