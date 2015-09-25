//
//  BLDetailedViewController.h
//  SLUSH
//
//  Created by Benjamin Laddin on 9/24/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Property;

@interface BLDetailedViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UILabel *BLHeader;
@property (weak, nonatomic) IBOutlet UILabel *BLDetailedLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *BLCollectionView;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (weak, nonatomic) IBOutlet UILabel *BLaddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *BLLengthLabel;
@property (strong, nonatomic) Property *property;
@property (weak, nonatomic) IBOutlet UILabel *BLBedAndBathroomLabel;
@property (weak, nonatomic) IBOutlet UILabel *BLSmokingPetsWash;
@property (weak, nonatomic) IBOutlet UILabel *BLLandLordInfo;
@property (weak, nonatomic) IBOutlet UILabel *BLPriceLabel;

@end
