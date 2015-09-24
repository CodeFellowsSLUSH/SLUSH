//
//  BrowseListingsTableViewController.h
//  SLUSH
//
//  Created by Benjamin Laddin on 9/22/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrowseListingCellsTableViewCell.h"
@class PropertyQueryFilter;

@interface BrowseListingsTableViewController : UITableViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSArray *properties;

@end
