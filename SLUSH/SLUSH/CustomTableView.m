//
//  CustomTableView.m
//  SLUSH
//
//  Created by Stephen Lardieri on 9/23/2015.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import "CustomTableView.h"


@interface CustomTableView ()

@property (nonatomic) bool ignoreBoundsChanges;

@end


@implementation CustomTableView


- (instancetype) initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  return self;
}

- (instancetype) init {
  self = [super init];
  return self;
}

- (instancetype) initWithFrame:(CGRect)frame {
  self = [super initWithFrame: frame];
  return self;
}


- (instancetype) initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
  self = [super initWithFrame: frame style: style];
  return self;
}


- (void) setBounds:(CGRect)bounds {

  if (self.ignoreBoundsChanges) {
    return;
  }

  [super setBounds: bounds];

}


- (void) ignoreAnimationsAndBoundsChanges: (bool) ignore {

  if (ignore) {

    [UIView setAnimationsEnabled: false];
    self.ignoreBoundsChanges = true;

  } else {

    [UIView setAnimationsEnabled: true];
    self.ignoreBoundsChanges = false;

  }
  
}

@end
