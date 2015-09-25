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
#import "User.h"
#import "ErrorAlertController.h"

@interface BLDetailedViewController ()

@end

@implementation BLDetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  self.BLHeader.text = self.property.headlineDescription;
  self.BLDetailedLabel.text = self.property.detailsDescription;
  self.automaticallyAdjustsScrollViewInsets = NO;
  self.BLPriceLabel.text = [NSString stringWithFormat:@"$%ld", (long)self.property.price];
  self.BLaddressLabel.text = self.property.address;
  NSString* months = [NSString stringWithFormat:@"Avalible For: %ld month", (long)self.property.monthsAvailable];
  self.BLLengthLabel.text = months;
  NSString* bedAndBath = [NSString stringWithFormat:@"%ld Beds: %ld Baths", (long)self.property.numberOfBedrooms, (long)self.property.numberOfBathrooms];
  self.BLBedAndBathroomLabel.text = bedAndBath;
  self.BLLandLordInfo.text = 
  self.BLSmokingPetsWash.text =
  
  
  
  

  

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

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  
  return collectionView.frame.size;
}

//-(void) viewDidLayoutSubviews{
//  CGFloat top = self.topLayoutGuide.length;
//  CGFloat bottom = self.bottomLayoutGuide.length;
//  UIEdgeInsets newInserts = UIEdgeInsetsMake(top, 0, bottom, 0);
//  self.BLCollectionView.contentInset = newInserts;
//}



@end
