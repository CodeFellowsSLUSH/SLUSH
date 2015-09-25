//
//  BLDetailedViewController.h
//  SLUSH
//
//  Created by Benjamin Laddin on 9/24/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Property;

@interface BLDetailedViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *BLHeader;
@property (weak, nonatomic) IBOutlet UILabel *BLDetailedLabel;

@property (strong, nonatomic) Property *property;

@end
