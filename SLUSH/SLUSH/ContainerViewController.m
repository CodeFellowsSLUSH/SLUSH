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
#import "FilterViewController.h"
#import "PropertyQueryFilter.h"

#define SegueIdentifierFirst @"listingSegue"
#define SegueIdentifierSecond @"mapSegue"

@interface ContainerViewController ()
@property (strong, nonatomic) NSString *currentSegueIdentifier;
@property (nonatomic) int Hello;
@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  self.currentSegueIdentifier = SegueIdentifierFirst;
  [self performSegueWithIdentifier:self.currentSegueIdentifier sender:nil];

}

-(void)swapViewControllers{
  self.currentSegueIdentifier = SegueIdentifierSecond;
  [self performSegueWithIdentifier:self.currentSegueIdentifier sender:nil];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier isEqualToString:SegueIdentifierFirst])
  {
    if (self.childViewControllers.count > 0) {
      [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:segue.destinationViewController];
    }
    else {
      [self addChildViewController:segue.destinationViewController];
      ((UIViewController *)segue.destinationViewController).view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
      [self.view addSubview:((UIViewController *)segue.destinationViewController).view];
      [segue.destinationViewController didMoveToParentViewController:self];
    }
  }
  else if ([segue.identifier isEqualToString:SegueIdentifierSecond])
  {
    [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:segue.destinationViewController];
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
  }];
}



//- (void)swapViewControllers
//{
//  self.currentSegueIdentifier = ([self.currentSegueIdentifier  isEqual: SegueIdentifierFirst]) ? SegueIdentifierSecond : SegueIdentifierFirst;
//  [self performSegueWithIdentifier:self.currentSegueIdentifier sender:nil];
//}



@end
