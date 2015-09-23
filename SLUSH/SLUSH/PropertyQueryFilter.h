//
//  PropertyQueryFilter.h
//  SLUSH
//
//  Created by Stephen Lardieri on 9/22/2015.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>

@class NSPredicate;


@interface PropertyQueryFilter : NSObject


@property (nonatomic) NSInteger minPrice;
@property (nonatomic) NSInteger maxPrice;

@property (nonatomic) NSInteger minBedrooms;
@property (nonatomic) NSInteger minBathrooms;

@property (nonatomic) BOOL allowsPets;
@property (nonatomic) BOOL allowsSmoking;
@property (nonatomic) BOOL hasWasherDryer;
@property (nonatomic) NSInteger minSquareFeet;

@property (strong, nonatomic) GMSPlace *searchNearPlace;
@property (nonatomic) double searchRadius;


// TODO: specific data sources, like Core Data or SQL Server, should provide these methods as categories of PropertyQueryFilter.
- (NSPredicate *) asPredicate;
- (NSString *) asSQLQuery;

@end
