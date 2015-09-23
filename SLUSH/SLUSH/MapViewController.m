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

@end

@implementation

MapViewController{}


-(void)loadView{
  self.kmapZoom = 15;
  self.kmapLat = 47.62;
  self.kmapLong = -122.33;

  GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.kmapLat longitude:self.kmapLong zoom: self.kmapZoom];
  self.mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
  self.view = self.mapView;
  
}

- (void)viewDidLoad {
    [super viewDidLoad];


  int i = 0;
  for (i = 0; i<self.listOfInterestedProperty.count; i++) {
    Property *specificPropertyInArray = self.listOfInterestedProperty[i];
    //get coordinates from address
    
//    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(10, 10);
//    GMSMarker *marker = [GMSMarker markerWithPosition:position];
//    marker.title = @"Hello World";
//    marker.map = mapView_;

  }
  
}

@end
