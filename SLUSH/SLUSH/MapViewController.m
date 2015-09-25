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
  firstProperty.headlineDescription = @"First Awesome Property";
  firstProperty.detailsDescription = @"uhhhhh......dude..";
  firstProperty.numberOfBathrooms = 4;
  firstProperty.numberOfBedrooms = 3;
  firstProperty.coordinate = CLLocationCoordinate2DMake(47.60, -122.33);
  [self.listOfInterestedProperty addObject:firstProperty];
  
  Property *secondProperty = [[Property alloc]init];
  secondProperty.headlineDescription = @"A Place";
  secondProperty.detailsDescription = @"sorry no bathroom";
  secondProperty.numberOfBathrooms = 0;
  secondProperty.numberOfBedrooms = 100;
  secondProperty.coordinate = CLLocationCoordinate2DMake(47.62, -122.31);
  [self.listOfInterestedProperty addObject:secondProperty];
  
  Property *thirdProperty = [[Property alloc]init];
  thirdProperty.headlineDescription = @"great house on the hill";
  thirdProperty.detailsDescription = @"i just saw a mdk outside";
  thirdProperty.numberOfBathrooms = 3;
  thirdProperty.numberOfBedrooms = 2;
  thirdProperty.coordinate = CLLocationCoordinate2DMake(47.63, -122.32);
  [self.listOfInterestedProperty addObject:thirdProperty];
  
  Property *fourthProperty = [[Property alloc]init];
  fourthProperty.headlineDescription = @"luxury mansion";
  fourthProperty.detailsDescription = @"Great property, no doors.";
  fourthProperty.numberOfBathrooms = 5;
  fourthProperty.numberOfBedrooms = 10;
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
    marker.title = specificPropertyInArray.headlineDescription;
    
    marker.snippet = [NSString stringWithFormat: @"%@ \n Bed/Bath: %ld/%ld",specificPropertyInArray.detailsDescription, (long)specificPropertyInArray.numberOfBedrooms, (long)specificPropertyInArray.numberOfBathrooms];

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
