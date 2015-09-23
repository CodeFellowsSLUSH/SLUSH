//
//  BrowseListingCellsTableViewCell.h
//  SLUSH
//
//  Created by Benjamin Laddin on 9/22/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface ImageCollectionView : UICollectionView

@property (strong, nonatomic) NSIndexPath *indexPath;

@end

static NSString *collectionViewCellIdentifier = @"imagesInCollectionView";

@interface BrowseListingCellsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UICollectionView *imageCollectionView;


@property (strong, nonatomic) ImageCollectionView* collectionView;
- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath;


@end

