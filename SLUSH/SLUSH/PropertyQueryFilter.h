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

@property (strong, nonatomic) NSNumber *minPrice;
@property (strong, nonatomic) NSNumber *maxPrice;

@property (strong, nonatomic) NSNumber *minBedrooms;
@property (strong, nonatomic) NSNumber *minBathrooms;

@property (nonatomic) BOOL allowsPets;
@property (nonatomic) BOOL allowsSmoking;
@property (nonatomic) BOOL hasWasherDryer;
@property (strong, nonatomic) NSNumber *minSquareFeet;

@property (strong, nonatomic) GMSPlace *searchNearPlace;
@property (strong, nonatomic) NSNumber *searchRadius;

@property (strong, nonatomic) NSPredicate *minPricePredicate;


// TODO: specific data sources, like Core Data or SQL Server, should provide these methods as categories of PropertyQueryFilter.
//- (NSPredicate *) asPredicate;
//- (NSString *) asSQLQuery;

@end
