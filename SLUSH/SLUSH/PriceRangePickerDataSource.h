//
//  PriceRangePickerDataSource.h
//  SLUSH
//
//  Created by Chris Budro on 9/22/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PriceRangePickerDataSource : NSObject <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) NSArray *minPrices;
@property (strong, nonatomic) NSArray *maxPrices;

- (void)setMinPrice:(NSNumber *)minPrice;
- (void)setMaxPrice:(NSNumber *)maxPrice;


@end
