//
//  MapViewController.m
//  SLUSH
//
//  Created by Benjamin Laddin on 9/21/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import "MapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "Property.h"
#import <CoreLocation/CoreLocation.h>

@interface MapViewController () <CLLocationManagerDelegate>
@property (nonatomic)float kmapZoom;
@property (nonatomic)float kmapLat;
@property (nonatomic)float kmapLong;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) GMSMapView *mapView;
@property (strong, nonatomic) GMSMutablePath *coordinateCollection;
@property (strong, nonatomic) GMSCoordinateBounds *bounds;

@end

@implementation


MapViewController{}




-(void)loadView{
  
  self.listOfInterestedProperty = [[NSMutableArray alloc]init];
  
  // for testing purposes of creating...
  Property *firstProperty = [[Property alloc]init];
  firstProperty.headline = @"First Awesome Property";
  firstProperty.propertyDescription = @"uhhhhh......dude..";
  firstProperty.numberOfBathrooms = [NSNumber numberWithInt:4];
  firstProperty.numberOfBedrooms = [NSNumber numberWithInt:3];
  firstProperty.coordinate = CLLocationCoordinate2DMake(47.60, -122.33);
  [self.listOfInterestedProperty addObject:firstProperty];
  
  Property *secondProperty = [[Property alloc]init];
  secondProperty.headline = @"A Place";
  secondProperty.propertyDescription = @"sorry no bathroom";
  secondProperty.numberOfBathrooms = [NSNumber numberWithInt:0];
  secondProperty.numberOfBedrooms = [NSNumber numberWithInt:100];
  secondProperty.coordinate = CLLocationCoordinate2DMake(47.62, -122.31);
  [self.listOfInterestedProperty addObject:secondProperty];
  
  Property *thirdProperty = [[Property alloc]init];
  thirdProperty.headline = @"great house on the hill";
  thirdProperty.propertyDescription = @"i just saw a mdk outside";
  thirdProperty.numberOfBathrooms = [NSNumber numberWithInt:3];
  thirdProperty.numberOfBedrooms = [NSNumber numberWithInt:2];
  thirdProperty.coordinate = CLLocationCoordinate2DMake(47.63, -122.32);
  [self.listOfInterestedProperty addObject:thirdProperty];
  
  Property *fourthProperty = [[Property alloc]init];
  fourthProperty.headline = @"luxury mansion";
  fourthProperty.propertyDescription = @"Great property, no doors.";
  fourthProperty.numberOfBathrooms = [NSNumber numberWithInt:5];
  fourthProperty.numberOfBedrooms = [NSNumber numberWithInt:10];
  fourthProperty.coordinate = CLLocationCoordinate2DMake(47.64, -122.33);
  [self.listOfInterestedProperty addObject:fourthProperty];
  // end testing
  
  
  if (!self.listOfInterestedProperty) {
    self.kmapZoom = 0;
    self.kmapLat = 43;
    self.kmapLong = -107.5;
  }
  GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.kmapLat longitude:self.kmapLong zoom: self.kmapZoom];
  self.mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
  self.view = self.mapView;
  
}


- (void)viewDidLoad {
    [super viewDidLoad];

  int i = 0;
  self.bounds = [[GMSCoordinateBounds alloc]init];
  for (i = 0; i<self.listOfInterestedProperty.count; i++) {
    Property *specificPropertyInArray = self.listOfInterestedProperty[i];
    GMSMarker *marker = [GMSMarker markerWithPosition:specificPropertyInArray.coordinate];
    marker.userData = specificPropertyInArray;
    marker.title = specificPropertyInArray.headline;
    
    marker.snippet = [NSString stringWithFormat: @"%@ \n Bed/Bath: %@/%@",specificPropertyInArray.propertyDescription, specificPropertyInArray.numberOfBedrooms, specificPropertyInArray.numberOfBathrooms];

//    self.coordinateCollection = [[GMSMutablePath alloc]init];
//    [self.coordinateCollection addCoordinate:specificPropertyInArray.coordinate];

    self.bounds = [self.bounds includingCoordinate:marker.position];
    
    marker.map = self.mapView;
  }
  
}

-(void)viewDidAppear:(BOOL)animated{
  animated = true;
  [self.mapView animateWithCameraUpdate:[GMSCameraUpdate fitBounds:self.bounds withPadding:30.0f]];

}


@end
