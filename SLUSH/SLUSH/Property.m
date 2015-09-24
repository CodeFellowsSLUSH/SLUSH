//
//  Property.m
//  SLUSH
//
//  Created by Chris Budro on 9/21/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import "Property.h"

CGFloat const kDefaultImageCompression = 0.8;

@interface Property ()

@property (strong, nonatomic) PFFile *imagesFile;
@property (strong, nonatomic) PFGeoPoint *geoPoint;

@end

@implementation Property

@dynamic headline;
@dynamic propertyDescription;
@dynamic numberOfBedrooms;
@dynamic numberOfBathrooms;
@dynamic allowsPets;
@dynamic price;
@synthesize placeDetails;
@dynamic streetAddress;
@dynamic city;
@dynamic unitNumber;
@dynamic zipCode;
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

@end





















