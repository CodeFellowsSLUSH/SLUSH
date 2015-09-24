//
//  PropertyQueryFilter.m
//  SLUSH
//
//  Created by Stephen Lardieri on 9/22/2015.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import "PropertyQueryFilter.h"

@implementation PropertyQueryFilter

-(PFGeoPoint *)searchNearGeoPoint {
  CLLocationCoordinate2D coordinate = _searchNearPlace.coordinate;
  return [PFGeoPoint geoPointWithLatitude:coordinate.latitude longitude:coordinate.longitude];
}

- (NSString *) asSQLQuery {

  return @"WHERE 1 == 1";
  
}


@end
