//
//  ListingViewController.m
//  SLUSH
//
//  Created by Mark Lin on 9/22/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import "ListingViewController.h"
#import "ContainerViewController.h"
#import "FilterViewController.h"
#import "ParseService.h"
#import "Constants.h"
#import <CoreLocation/CoreLocation.h>
#import "GooglePlaceService.h"
#import "ErrorAlertController.h"
#import "PropertyQueryFilter.h"


NSString * const kFilterStoryboardID = @"FilterViewController";

@interface ListingViewController () <FilterManagerDelegate, CLLocationManagerDelegate>
@property (strong, nonatomic) ContainerViewController *containerViewController;
@property (strong, nonatomic) CLLocationManager *locationManager;

- (IBAction)toggleButton:(id)sender;

@end

@implementation ListingViewController

@synthesize filter = _filter;

-(void)viewDidLoad{
  
  self.title = @"Browse Properties";
  
  UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(filterWasPressed)];
  self.navigationItem.leftBarButtonItem = filterButton;
  
  UIBarButtonItem *toggleButton = [[UIBarButtonItem alloc] initWithTitle:@"Map" style:UIBarButtonItemStylePlain target:self action:@selector(toggleButtonWasPressed:)];
  self.navigationItem.rightBarButtonItem = toggleButton;
  
  [self loadProperties];
  
  self.locationManager.delegate = self;
  [self.locationManager requestWhenInUseAuthorization];

}

- (void)filterWasPressed {
  FilterViewController *filterVC = [self.storyboard instantiateViewControllerWithIdentifier:kFilterStoryboardID];
  filterVC.filter = self.filter;
  filterVC.delegate = self;
  [self.navigationController pushViewController:filterVC animated:true];
}

- (void)toggleButtonWasPressed:(UIBarButtonItem *)button {
  if ([button.title isEqualToString:@"Map"]) {
    [button setTitle:@"List"];
  } else if ([button.title isEqualToString:@"List"]) {
    [button setTitle:@"Map"];
  }
  [self.containerViewController swapViewControllers];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier isEqualToString:@"embedContainer"]) {
    self.containerViewController = segue.destinationViewController;
  }
}

- (IBAction)toggleButton:(id)sender
{
[self.containerViewController swapViewControllers];
}

#pragma mark - Helper Methods

- (void)loadProperties {
  [ParseService propertiesWithFilter:self.filter completionHandler:^(NSArray *properties, NSError *error) {
    if (error) {
      NSLog(@"error: %@", error.localizedDescription);
    } else {
      NSDictionary *userInfo = @{ kPropertiesListKey: properties };
      [[NSNotificationCenter defaultCenter] postNotificationName:kPropertiesDidLoadNotification object:nil userInfo:userInfo];
    }
  }];
}

#pragma mark - Filter Manager Delegate

-(void)filterManager:(FilterViewController *)filterManager didApplyFilter:(PropertyQueryFilter *)filter {
  self.filter = filter;
  [self loadProperties];
  [self.navigationController popToRootViewControllerAnimated:true];
}

-(CLLocationManager *)locationManager {
  if (!_locationManager) {
    _locationManager = [[CLLocationManager alloc] init];
  }
  return _locationManager;
}

#pragma mark - Location Manager Delegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
  if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
    [GooglePlaceService currentPlaceWithBlock:^(GMSPlace *place, NSError *error) {
      if (error) {
        UIAlertController *alert = [ErrorAlertController alertWithError:error];
        [self presentViewController:alert animated:true completion:nil];
      } else {
        self.filter.searchNearPlace = place;
        NSDictionary *userInfo = @{kFilterUserInfoKey: self.filter };
        [[NSNotificationCenter defaultCenter] postNotificationName:kFilterDidChangeNotification object:nil userInfo:userInfo];
      }
    }];
  }
}

-(PropertyQueryFilter *)filter {
  if (!_filter) {
    _filter = [[PropertyQueryFilter alloc] init];
  }
  return _filter;
}

-(void)setFilter:(PropertyQueryFilter *)filter {
  _filter = filter;
}

@end
