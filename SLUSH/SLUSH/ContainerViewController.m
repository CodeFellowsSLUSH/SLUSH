//
//  ContainerViewController.m
//  SLUSH
//
//  Created by Mark Lin on 9/22/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import "ContainerViewController.h"
#import "ListingViewController.h"
#import "MapViewController.h"
#import "BrowseListingsTableViewController.h"
#import "MapViewController.h"

#define SegueID1 @"listingSegue"
#define SegueID2 @"mapSegue"


@interface ContainerViewController ()
@property (strong, nonatomic) NSString *currentSegueIdentifier;
@property (nonatomic) BOOL inTransition;
@property (strong, nonatomic) BrowseListingsTableViewController *browseVC;
@property (strong, nonatomic) MapViewController *mapVC;
@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.inTransition = false;
  self.currentSegueIdentifier = SegueID1;
  [self performSegueWithIdentifier:self.currentSegueIdentifier sender:nil];

}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier isEqualToString:SegueID1]) {
    self.browseVC = segue.destinationViewController;
  }
  
  if ([segue.identifier isEqualToString:SegueID2]) {
    self.mapVC = segue.destinationViewController;
  }
  
  if ([segue.identifier isEqualToString:SegueID1]) {
    if (self.childViewControllers.count > 0) {
      [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:self.browseVC];
    }
    else {

      [self addChildViewController:segue.destinationViewController];
      UIView* destView = ((UIViewController *)segue.destinationViewController).view;
      destView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
      destView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
      [self.view addSubview:destView];
      [segue.destinationViewController didMoveToParentViewController:self];
    }
  }

  else if ([segue.identifier isEqualToString:SegueID2]) {
    [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:self.mapVC];
  }
}

- (void)swapFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController
{
  toViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
  
  [fromViewController willMoveToParentViewController:nil];
  [self addChildViewController:toViewController];
  [self transitionFromViewController:fromViewController toViewController:toViewController duration:1.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
    [fromViewController removeFromParentViewController];
    [toViewController didMoveToParentViewController:self];
    self.inTransition = false;
  }];
}


-(void)swapViewControllers{
  if (self.inTransition){
    return;
  }
  self.inTransition = true;
  self.currentSegueIdentifier = ([self.currentSegueIdentifier isEqualToString:SegueID1]) ? SegueID2:SegueID1;
  
  if (([self.currentSegueIdentifier isEqualToString:SegueID1] && self.browseVC)) {
    [self swapFromViewController:self.browseVC toViewController:self.mapVC];
    return;
  }
  
  if (([self.currentSegueIdentifier isEqualToString:SegueID2] && self.mapVC)) {
    [self swapFromViewController:self.mapVC toViewController:self.browseVC];
    return;
  }
  
  
  [self performSegueWithIdentifier:self.currentSegueIdentifier sender:self];
}




@end
