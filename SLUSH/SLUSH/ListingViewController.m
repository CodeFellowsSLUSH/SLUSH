//
//  ListingViewController.m
//  SLUSH
//
//  Created by Mark Lin on 9/22/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import "ListingViewController.h"
#import "ContainerViewController.h"

@interface ListingViewController ()

@property (nonatomic, strong) ContainerViewController *containerViewController;
- (IBAction)toggleButton:(id)sender;

@end

@implementation ListingViewController

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
  return YES;
}
-(void)viewDidLoad{
  [super viewDidLoad];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier isEqualToString:@"embedContainer"]) {
    self.containerViewController = segue.destinationViewController;
  }
}

- (IBAction)toggleButton:(id)sender
{
[self.containerViewController swapViewControllers];
}

@end
