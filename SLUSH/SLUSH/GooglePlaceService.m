//
//  GooglePlaceService.m
//  SLUSH
//
//  Created by Chris Budro on 9/22/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import "GooglePlaceService.h"

@implementation GooglePlaceService

+ (void)autoCompletePredictionsFromSearchTerm:(NSString *)searchTerm withBlock:(void (^)(NSArray *predictions, NSError *error))handler {
  
  GMSPlacesClient *placesClient = [GMSPlacesClient sharedClient];
  [placesClient autocompleteQuery:searchTerm bounds:nil filter:nil callback:^(NSArray * _Nullable results, NSError * _Nullable error) {
    if (error) {
      handler(nil, error);
    } else {
      handler(results, nil);
    }
  }];
}

+ (void)googlePlaceForAutocompletePrediction:(GMSAutocompletePrediction *)prediction withBlock:(void (^)(GMSPlace *place, NSError *error))handler {
  
  GMSPlacesClient *placesClient = [GMSPlacesClient sharedClient];
  [placesClient lookUpPlaceID:prediction.placeID callback:^(GMSPlace * _Nullable result, NSError * _Nullable error) {
    if (error) {
      handler(nil, error);
    } else {
      handler(result, nil);
    }
  }];
}

+ (void)currentPlace {
  GMSPlacesClient *placesClient = [GMSPlacesClient sharedClient];
  [placesClient currentPlaceWithCallback:^(GMSPlaceLikelihoodList * _Nullable likelihoodList, NSError * _Nullable error) {
    
    
  }];
}


@end
