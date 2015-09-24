//
//  PriceRangePickerDataSource.m
//  SLUSH
//
//  Created by Chris Budro on 9/22/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import "PriceRangePickerDataSource.h"
#import "Constants.h"

NSInteger const kNumberOfPickerRows = 100;
NSInteger const kNumberOfPickerComponents = 2;
NSInteger const kRentMultiplier = 100;

@interface PriceRangePickerDataSource ()

@property (strong, nonatomic) NSArray *prices;

@end

@implementation PriceRangePickerDataSource

-(instancetype)init {
  self = [super init];
  if (self) {
    NSArray *prices = [self buildPrices];
    self.prices = prices;
    self.minPrices = prices;
    self.maxPrices = prices;
  }
  return self;
}

#pragma mark - Picker Data Source

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  if (component == kMinRentComponent) {
    return self.minPrices.count;
  } else if (component == kMaxRentComponent) {
    return self.maxPrices.count;
  }
  return 0;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  return kNumberOfPickerComponents;
}

#pragma mark - Picker Delegate

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
  
  NSNumber *price;
  NSString *noLimitString;
  
  if (component == kMinRentComponent) {
    price = self.minPrices[row];
    noLimitString = @"No Min";
  } else if (component == kMaxRentComponent) {
    price = self.maxPrices[row];
    noLimitString = @"No Max";
  }
  
  if ([price isEqualToNumber:@0]) {
    return noLimitString;
  }
  return [NSString stringWithFormat:@"$%@", price];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
  if (component == kMinRentComponent) {
    NSMutableArray *newMaxPrices = [NSMutableArray arrayWithArray:[self.prices subarrayWithRange:NSMakeRange(row, self.prices.count - row)]];
    
    if (![newMaxPrices[0] isEqualToNumber:@0]) {
      [newMaxPrices insertObject:@0 atIndex:0];
    }
    
    NSInteger currentMaxRentRow = [pickerView selectedRowInComponent:kMaxRentComponent];
    NSNumber *currentMaxRent = self.maxPrices[currentMaxRentRow];
    
    self.maxPrices = newMaxPrices;
    if (self.minPrices[row] > currentMaxRent) {
      [pickerView selectRow:0 inComponent:kMaxRentComponent animated:true];
    } else {
      NSInteger newMaxRentRow = [self.maxPrices indexOfObject:currentMaxRent];
      [pickerView selectRow:newMaxRentRow inComponent:kMaxRentComponent animated:false];
    }
    [pickerView reloadComponent:kMaxRentComponent];
  } else if (component == kMaxRentComponent) {
    NSMutableArray *newMinPrices = [NSMutableArray arrayWithArray:[self.prices subarrayWithRange:NSMakeRange(0, self.prices.count - row)]];
    if (![newMinPrices[0] isEqualToNumber:@0]) {
      [newMinPrices insertObject:@0 atIndex:0];
    }
    
    NSInteger currentMinRentRow = [pickerView selectedRowInComponent:kMinRentComponent];
    NSNumber *currentMinRent = self.minPrices[currentMinRentRow];
    
    self.minPrices = newMinPrices;
    if (self.maxPrices[row] < currentMinRent && row != 0) {
      [pickerView selectRow:0 inComponent:kMinRentComponent animated:true];
    } else {
      NSInteger newMinRentRow = [self.minPrices indexOfObject:currentMinRent];
      [pickerView selectRow:newMinRentRow inComponent:kMinRentComponent animated:false];
    }
    [pickerView reloadComponent:kMinRentComponent];
  }
}


#pragma mark - Helper Methods
- (NSArray *)buildPrices {
  NSMutableArray *prices = [[NSMutableArray alloc] init];
  
  for (NSInteger i = 0; i <= kNumberOfPickerRows; i++) {
    NSNumber *number = [NSNumber numberWithLong:(i * kRentMultiplier)];
    [prices addObject:number];
  }
  return prices;
}

- (NSNumber *)minPriceForRow:(NSInteger)row {
  return self.minPrices[row];
}

- (NSNumber *)maxPriceForRow:(NSInteger)row {
  return self.maxPrices[row];
}

- (void)setMinPrice:(NSNumber *)minPrice {
  
}
- (void)setMaxPrice:(NSNumber *)maxPrice {
  
}

@end
