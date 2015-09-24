//
//  BrowseListingCellsTableViewCell.m
//  SLUSH
//
//  Created by Benjamin Laddin on 9/22/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import "BrowseListingCellsTableViewCell.h"


@implementation BrowseListingCellsTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
  
  if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;

  return self;
}

-(void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource,UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath{
  
  self.collectionView.dataSource = dataSourceDelegate;
  self.collectionView.delegate = dataSourceDelegate;
  self.collectionView.indexPath = indexPath;
  
  
  [self.collectionView reloadData];
}

@end

