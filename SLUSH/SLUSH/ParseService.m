//
//  ParseService.m
//  SLUSH
//
//  Created by Chris Budro on 9/23/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import "ParseService.h"
#import "PropertyQueryFilter.h"
#import "Property.h"

@implementation ParseService

+ (void)propertiesWithFilter:(PropertyQueryFilter *)filter completionHandler:(void (^)(NSArray *properties, NSError *))handler {
  PFQuery *query = [Property query];
  if (filter) {
    if (filter.minPrice) {
      [query whereKey:@"price" greaterThanOrEqualTo:filter.minPrice];
    }
    if (filter.maxPrice && ![filter.maxPrice isEqualToNumber:@0]) {
      [query whereKey:@"price" lessThanOrEqualTo:filter.maxPrice];
    }
    if (filter.minBedrooms && ![filter.minBedrooms isEqualToNumber:@0]) {
      [query whereKey:@"numberOfBedrooms" greaterThanOrEqualTo:filter.minBedrooms];
    }
    if (filter.minBathrooms && ![filter.minBathrooms isEqualToNumber:@0]) {
      [query whereKey:@"numberOfBathrooms" greaterThanOrEqualTo:filter.minBathrooms];
    }
#warning set search radius in filter view controller
    [query whereKey:@"geoPoint" nearGeoPoint:filter.searchNearGeoPoint withinMiles:50];
  }
  
  [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
    if (error) {
      handler(nil, error);
    } else {
      handler(objects, nil);
    }
  }];
}

+ (void)fetchImageObject:(PFObject *)imageObject withBlock:(void(^)(UIImage *image, NSError *error))handler {
  [imageObject fetchIfNeededInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
    PFFile *imageFile = object[@"file"];
    [imageFile getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
      if (error) {
        handler(nil, error);
      } else {
        UIImage *image = [UIImage imageWithData:data];
        handler(image, nil);
      }
    }];
  }];
}

+ (void)uploadTestProperties {
  
  Property *property = [Property object];
  [property addImage:[UIImage imageNamed:@"modernHouse"] withBlock:^(BOOL succeeded, NSError *error) {
    if (error) {
      NSLog(@"error: %@", error.localizedDescription);
    }
  }];
  
  [property addImage:[UIImage imageNamed:@"craftsman"] withBlock:^(BOOL succeeded, NSError *error) {
    if (error) {
      NSLog(@"error: %@", error.localizedDescription);
    }
  }];
  
  [property addImage:[UIImage imageNamed:@"seattleRoom"] withBlock:^(BOOL succeeded, NSError *error) {
    if (error) {
      NSLog(@"error: %@", error.localizedDescription);
    }
  }];
  
  property.allowsPets = true;
  property.numberOfBathrooms = @3;
  property.numberOfBedrooms = @1;
  property.headline = @"Charming 1BR in Ballard";
  property.propertyDescription = @"sdlkajsd;fljasdlfkjsaldkfjasl;dfjkals;dfjklasdkjfl;sdfjlskda;jf;lasdfjks;dlfkj;asldfjk";
  property.price = @750;
  
  [property saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
    if (error) {
      NSLog(@"Error: %@", error.localizedDescription);
    }
  }];
}

@end
