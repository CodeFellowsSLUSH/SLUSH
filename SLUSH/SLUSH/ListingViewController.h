//
//  ListingViewController.h
//  SLUSH
//
//  Created by Mark Lin on 9/22/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PropertyQueryFilter;

@interface ListingViewController : UIViewController

@property (strong, nonatomic) PropertyQueryFilter *filter;

@end
