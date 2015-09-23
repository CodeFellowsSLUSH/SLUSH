//
//  ListingViewController.m
//  SLUSH
//
//  Created by Mark Lin on 9/22/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import "ListingViewController.h"
#import "ContainerViewController.h"
#import "FilterViewController.h"

NSString * const kFilterStoryboardID = @"FilterViewController";

@interface ListingViewController () <FilterManagerDelegate>
@property (nonatomic, strong) ContainerViewController *containerViewController;
- (IBAction)toggleButton:(id)sender;

@end

@implementation ListingViewController

-(void)viewDidLoad{
  self.containerViewController = [[ContainerViewController alloc]init];
  
  UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(filterWasPressed)];
  NSLog(@"nav bar: %@", self.navigationItem);
  self.navigationItem.rightBarButtonItem = filterButton;
}

- (void)filterWasPressed {
  FilterViewController *filterVC = [self.storyboard instantiateViewControllerWithIdentifier:kFilterStoryboardID];
  filterVC.filter = self.filter;
  filterVC.delegate = self;
  [self.navigationController pushViewController:filterVC animated:true];
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

#pragma mark - Filter Manager Delegate

-(void)filterManager:(FilterViewController *)filterManager didApplyFilter:(PropertyQueryFilter *)filter {
  self.filter = filter;
  [self.navigationController popToRootViewControllerAnimated:true];
}

@end
