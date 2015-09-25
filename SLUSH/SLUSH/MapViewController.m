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
#import "Constants.h"
#import "PropertyQueryFilter.h"
#import "ContainerViewController.h"
#import "ParseService.h"
#import "ErrorAlertController.h"

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
  
  self.properties = [[NSArray alloc]init];

  if (!self.properties) {
    self.kmapZoom = 0;
    self.kmapLat = 43;
    self.kmapLong = -107.5;
  }
  GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.kmapLat longitude:self.kmapLong zoom: self.kmapZoom];
  self.mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
  self.view = self.mapView;
  
}

-(void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(propertiesDidLoad:) name:kPropertiesDidLoadNotification object:nil];
  
  ContainerViewController *parentVC = (ContainerViewController *)self.parentViewController;
  self.filter = parentVC.filter;
  [ParseService propertiesWithFilter:parentVC.filter completionHandler:^(NSArray *properties, NSError *error) {
    if (error) {
      UIAlertController *alert = [ErrorAlertController alertWithError:error];
      [self presentViewController:alert animated:true completion:nil];
    } else {
      self.properties = properties;
      [self updateMapRegion];
    }
  }];
}

-(void)updateMapRegion {
  self.bounds = [[GMSCoordinateBounds alloc]init];
  for (int i = 0; i < self.properties.count; i++) {
    Property *specificPropertyInArray = self.properties[i];
    GMSMarker *marker = [GMSMarker markerWithPosition:specificPropertyInArray.coordinate];
    marker.userData = specificPropertyInArray;
    marker.title = specificPropertyInArray.headlineDescription;
    
    marker.snippet = [NSString stringWithFormat: @"%@ \n Bed/Bath: %ld/%ld",specificPropertyInArray.detailsDescription, (long)specificPropertyInArray.numberOfBedrooms, (long)specificPropertyInArray.numberOfBathrooms];
    
    self.bounds = [self.bounds includingCoordinate:marker.position];
    
    marker.map = self.mapView;
  }
}

-(void)viewDidAppear:(BOOL)animated{
  animated = true;
  [self.mapView animateWithCameraUpdate:[GMSCameraUpdate fitBounds:self.bounds withPadding:30.0f]];

}

- (void)propertiesDidLoad:(NSNotification *)notification {
  NSDictionary *userInfo = notification.userInfo;
  NSArray *properties = userInfo[kPropertiesListKey];
  self.properties = properties;
  [self updateMapRegion];
}


@end
