//
//  FilterViewController.h
//  SLUSH
//
//  Created by Benjamin Laddin on 9/21/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationSearchResultsController.h"

@class PropertyQueryFilter;
@class FilterViewController;

@protocol FilterManagerDelegate <NSObject>

- (void)filterManager:(FilterViewController *)filterManager didApplyFilter:(PropertyQueryFilter *)filter;

@end

@interface FilterViewController : UITableViewController <UISearchResultsUpdating, LocationPickerDelegate>

@property (weak, nonatomic) id <FilterManagerDelegate> delegate;
@property (strong, nonatomic) PropertyQueryFilter *filter;

@end
