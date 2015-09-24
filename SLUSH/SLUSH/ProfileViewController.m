//
//  ProfileViewController.m
//  SLUSH
//
//  Created by Benjamin Laddin on 9/21/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import "ProfileViewController.h"
#import "LoginViewController.h"
#import "Property.h"
#import "NewPropertyViewController.h"


@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
}

// Put the Add Property button in the top right corner.
// Must do this each time we appear.
- (void) viewWillAppear:(BOOL)animated {
  [super viewWillAppear: animated];
}


// Get ready to segue to the property detail view controller.
- (void)prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender {

  if ( [[segue destinationViewController] isKindOfClass: [NewPropertyViewController class]] ) {

    NewPropertyViewController * propertyVC = (NewPropertyViewController *) [segue destinationViewController];

    if (sender == self.navigationItem.rightBarButtonItem) {

      Property * newProperty = [Property object];
      newProperty.landlordId = @"some landlord"; // TODO: replace this with the objectId of our own User object!
      propertyVC.property = newProperty;

    } else {
      NSLog(@"Unknown sender!");
    }

  } else {

    NSLog(@"Unknown destination VC!");

  }

}

@end
