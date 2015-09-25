//
//  BLDetailedViewController.m
//  SLUSH
//
//  Created by Benjamin Laddin on 9/24/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import "BLDetailedViewController.h"
#import "Property.h"
#import "BLDetailedCollectionViewCell.h"
#import "ParseService.h"

@interface BLDetailedViewController ()

@end

@implementation BLDetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  self.BLHeader.text = self.property.headlineDescription;
  self.BLDetailedLabel.text = self.property.detailsDescription;
  
  
  

}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
  return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  
  return self.property.photos.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
  
  BLDetailedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DetailedCollectionViewCell" forIndexPath:indexPath];
  
  PFObject *imageObject = self.property.photos[indexPath.row];
  
  cell.tag++;
  NSInteger tag = cell.tag;
  

  [ParseService fetchImageObject:imageObject withBlock:^(UIImage *image, NSError *error) {
    if (!error) {
      if (tag == cell.tag) {
        cell.blImageView.image = image;
      }
      
      
    }
  }];
  
  return cell;
  
}

-(CGSize)collectionView:(UICollectionView *) collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
  return CGSizeMake(600, 400);
}


@end
