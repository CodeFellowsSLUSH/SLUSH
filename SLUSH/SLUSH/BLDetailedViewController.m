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

@interface BLDetailedViewController ()

@end

@implementation BLDetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  self.BLHeader.text = self.property.headlineDescription;
  self.BLDetailedLabel.text = self.property.detailsDescription;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.


}


@end
