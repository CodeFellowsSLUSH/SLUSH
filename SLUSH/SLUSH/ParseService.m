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

CGFloat const kDefaultSearchRadius = 50;

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
    CGFloat searchRadius = (filter.searchRadius) ? filter.searchRadius : kDefaultSearchRadius;
    
    if (filter.searchNearGeoPoint && filter.searchNearGeoPoint.latitude != 0 && filter.searchNearGeoPoint.longitude != 0) {
      NSLog(@"Filter: %@", filter.searchNearGeoPoint);
      [query whereKey:@"geoPoint" nearGeoPoint:filter.searchNearGeoPoint withinMiles:searchRadius];
    }
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

@end
