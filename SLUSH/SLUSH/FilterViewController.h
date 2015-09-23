//
//  FilterViewController.h
//  SLUSH
//
//  Created by Benjamin Laddin on 9/21/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PropertyQueryFilter;
@class FilterViewController;
@class FilterManagerDelegate;

@protocol FilterManagerDelegate <NSObject>

- (void)filterManager:(FilterViewController *)filterManager didApplyFilter:(PropertyQueryFilter *)filter;

@end

@interface FilterViewController : UITableViewController <UISearchResultsUpdating>

@property (weak, nonatomic) id <FilterManagerDelegate> delegate;
@property (strong, nonatomic) PropertyQueryFilter *filter;

@end
