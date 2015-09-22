//
//  FilterViewController.h
//  SLUSH
//
//  Created by Benjamin Laddin on 9/21/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FilterViewController;
@class FilterManagerDelegate;

@protocol FilterManagerDelegate <NSObject>

//- (void)filterManager:(FilterViewController *)filterManager didApplyFilter:(Filter *)filter;

@end

@interface FilterViewController : UITableViewController

@property (weak, nonatomic) FilterManagerDelegate *delegate;



@end
