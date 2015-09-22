//
//  BrowseListingCellsTableViewCell.h
//  SLUSH
//
//  Created by Benjamin Laddin on 9/22/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowseListingCellsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectionView;

@end
