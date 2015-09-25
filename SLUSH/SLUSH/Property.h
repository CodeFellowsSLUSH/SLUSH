//
//  Property.h
//  SLUSH
//
//  Created by Chris Budro on 9/21/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMaps/GoogleMaps.h>
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>


@class User;


@interface Property : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString * landlordId;

@property (nonatomic, strong) NSString * headlineDescription;
@property (nonatomic, strong) NSString * detailsDescription;

@property (nonatomic) NSInteger price;
@property (nonatomic) NSInteger monthsAvailable;


@property (nonatomic) NSInteger numberOfBedrooms;
@property (nonatomic) NSInteger numberOfBathrooms;
@property (nonatomic) NSInteger squareFeet;

@property (nonatomic) BOOL allowsSmoking;
@property (nonatomic) BOOL allowsPets;
@property (nonatomic) BOOL hasWasherDryer;

@property (strong, nonatomic) NSString * address;

@property (strong, nonatomic) NSArray *photos;
@property (nonatomic) CLLocationCoordinate2D coordinate;

@property (strong, nonatomic) GMSPlace *googlePlace;

- (void)addImage:(UIImage *)image withBlock:(void(^)(BOOL succeeded, NSError *error))handler;

- (void) save;

+ (Property *) generateTestPropertyForLandlord: (User *) landlord;


@end
