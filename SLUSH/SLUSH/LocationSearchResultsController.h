//
//  LocationSearchResultsController.h
//  SLUSH
//
//  Created by Chris Budro on 9/22/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
@class LocationSearchResultsController;

@protocol LocationPickerDelegate <NSObject>

- (void)locationPicker:(LocationSearchResultsController *)picker didPickPlace:(GMSPlace *)place;

@end

@interface LocationSearchResultsController : UITableViewController

@property (strong, nonatomic) NSArray *searchResults;
@property (weak, nonatomic) id <LocationPickerDelegate> delegate;

@end
