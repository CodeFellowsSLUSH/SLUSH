//
//  GooglePlaceService.h
//  SLUSH
//
//  Created by Chris Budro on 9/22/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMaps/GoogleMaps.h>

@interface GooglePlaceService : NSObject

+ (void)autoCompletePredictionsFromSearchTerm:(NSString *)searchTerm withBlock:(void (^)(NSArray *predictions, NSError *error))handler;
+ (void)googlePlaceForAutocompletePrediction:(GMSAutocompletePrediction *)prediction withBlock:(void (^)(GMSPlace *place, NSError *error))handler;
+ (void)currentPlaceWithBlock:(void(^)(GMSPlace *place, NSError *error))handler;

@end
