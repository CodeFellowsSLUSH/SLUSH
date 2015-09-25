//
//  MapViewController.h
//  SLUSH
//
//  Created by Benjamin Laddin on 9/21/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PropertyQueryFilter;

@interface MapViewController : UIViewController

@property (strong, nonatomic) NSArray *properties;
@property (strong, nonatomic) PropertyQueryFilter *filter;


@end
