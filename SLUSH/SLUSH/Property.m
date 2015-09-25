//
//  Property.m
//  SLUSH
//
//  Created by Chris Budro on 9/21/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import "Property.h"

#import "User.h"


CGFloat const kDefaultImageCompression = 0.8;

@interface Property ()

@property (strong, nonatomic) PFFile *imagesFile;
@property (strong, nonatomic) PFGeoPoint *geoPoint;

@end

@implementation Property

@dynamic landlordId;

@dynamic headlineDescription;
@dynamic detailsDescription;

@dynamic price;
@dynamic monthsAvailable;

@dynamic numberOfBedrooms;
@dynamic numberOfBathrooms;
@dynamic squareFeet;

@dynamic allowsSmoking;
@dynamic allowsPets;
@dynamic hasWasherDryer;

@synthesize googlePlace;

@dynamic address;

@dynamic imagesFile;
@dynamic photos;
@dynamic geoPoint;




+ (NSString *)parseClassName {
  return @"Property";
}

- (void)addImage:(UIImage *)image withBlock:(void(^)(BOOL succeeded, NSError *error))handler {
  NSData *imageData = UIImageJPEGRepresentation(image, kDefaultImageCompression);
  PFFile *imageFile = [PFFile fileWithData:imageData];
  PFObject *photo = [PFObject objectWithClassName:@"Photo"];
  photo[@"file"] = imageFile;
  [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
    if (succeeded) {
      [self addUniqueObject:photo forKey:@"photos"];
      [self saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
          handler(false, error);
        } else if (succeeded) {
          handler(true, nil);
        }
      }];
    }
  }];
}

-(void)setCoordinate:(CLLocationCoordinate2D)coordinate {
  PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:coordinate.latitude longitude:coordinate.longitude];
  self.geoPoint = geoPoint;
}


-(CLLocationCoordinate2D)coordinate {
  CGFloat latitude = self.geoPoint.latitude;
  CGFloat longitude = self.geoPoint.longitude;
  CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
  
  return coordinate;
}


- (void) save {

  [self saveEventually];

}


+ (Property *) generateTestPropertyForLandlord: (User *) landlord {

  static const CLLocationDegrees latitudeOfCodeFellows = 47.62354;
  static const CLLocationDegrees longitudeOfCodeFellows = -122.3362;

  NSArray * headlines = @[ @"Charming duplex!", @"Cute condo!", @"Hip loft!", @"Spacious house!" ];
  NSArray * descriptions = @[ @"Active living downtown", @"Quiet neighborhood, good schools", @"Full-service amenities", @"Huge back yard" ];


  Property * property = [Property object];

  if (landlord) {
    property.landlordId = landlord.objectId;
  } else {
    property.landlordId = [NSString stringWithFormat: @"%8.8u", arc4random_uniform(100000000)];
  }

  property.headlineDescription = [headlines objectAtIndex: arc4random_uniform((unsigned int)headlines.count)];
  property.detailsDescription = [descriptions objectAtIndex: arc4random_uniform((unsigned int)descriptions.count)];

  property.price = arc4random_uniform(20) * 50 + 700;
  property.monthsAvailable = arc4random_uniform(11) + 1;

  property.numberOfBedrooms = arc4random_uniform(5) + 1;
  property.numberOfBathrooms = arc4random_uniform(3) + 1;
  property.squareFeet = arc4random_uniform(15) * 100 + 600;

  property.allowsPets = arc4random_uniform(2) > 0 ? true : false;
  property.allowsSmoking = arc4random_uniform(2) > 0 ? true : false;
  property.hasWasherDryer = arc4random_uniform(2) > 0 ? true : false;

  property.geoPoint = [PFGeoPoint geoPointWithLatitude: latitudeOfCodeFellows + ( 0.005 - (double)arc4random_uniform(100) / 10000.0) longitude: longitudeOfCodeFellows + ( 0.005 - (double)arc4random_uniform(100) / 10000.0)];

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

  return property;
  
}

@end





















