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
  
  
  self.imageCollectionView = [[UICollectionView alloc] init];
  [self.imageCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:collectionViewCellIdentifier];
  [self.contentView addSubview:self.contentView];
  
  return self;
}

@end

