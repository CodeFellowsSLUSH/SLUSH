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
#import "User.h"


@interface ProfileViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@end


@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];

  if (!self.user) {

    self.user = [User object];
//    self.user = [User generateTestUser];

    // Save now, so we have our object ID when we segue to properties.
    [self.user save];

  }

  [self loadUIFromUser];

}

// Put the Add Property button in the top right corner.
// Must do this each time we appear.
- (void) viewWillAppear:(BOOL)animated {
  [super viewWillAppear: animated];
}


- (void) loadUIFromUser {

  self.nameTextField.text = self.user.name;
  self.phoneTextField.text = self.user.phoneNumber;
  self.emailTextField.text = self.user.emailAddress;

}


- (void) saveUIToUser {

  self.user.name = self.nameTextField.text;
  self.user.phoneNumber = self.phoneTextField.text;
  self.user.emailAddress = self.emailTextField.text;

}


// Get ready to segue to the property detail view controller.
- (void)prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender {

  if ( [[segue destinationViewController] isKindOfClass: [NewPropertyViewController class]] ) {

    NewPropertyViewController * propertyVC = (NewPropertyViewController *) [segue destinationViewController];

    if (sender == self.navigationItem.rightBarButtonItem) {

//      Property * newProperty = [Property generateTestPropertyForLandlord: self.user];

      Property * newProperty = [Property object];
      newProperty.landlordId = self.user.objectId;

      propertyVC.property = newProperty;

    } else {
      NSLog(@"Unknown sender!");
    }

  } else {

    NSLog(@"Unknown destination VC!");

  }

}

@end
