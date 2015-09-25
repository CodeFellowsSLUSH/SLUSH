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
#import "LoginViewController.h"


// Magic:
static NSString * const kLoginVC = @"LoginVC";


@interface ProfileViewController () <PFLogInViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (nonatomic) bool disableSave;

@end


@implementation ProfileViewController

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void) viewWillAppear: (BOOL) animated {
  
  [super viewWillAppear: animated];

  self.user = [User currentUser];

  // If we have a logged-in user, populate the UI fields from the user's properties.
  if (self.user) {

    [self loadUIFromUser];

  } else {

    // Present the login VC.
    LoginViewController * loginVC = (LoginViewController *) [self.storyboard instantiateViewControllerWithIdentifier:kLoginVC];
    loginVC.delegate = self;
    [self presentViewController: loginVC animated: true completion: nil];

  }

}


- (void) viewWillDisappear: (BOOL) animated {

  [self saveUIToUser];
  [self.user save];

  [super viewWillDisappear: animated];

}

- (void) loadUIFromUser {

  self.nameTextField.text = self.user.name;
  if (self.disableSave) {
    self.nameTextField.enabled = false;
  }

  self.phoneTextField.text = self.user.phoneNumber;
  if (self.disableSave) {
    self.phoneTextField.enabled = false;
  }

  self.emailTextField.text = self.user.email;
  if (self.disableSave) {
    self.emailTextField.enabled = false;
  }

}


- (void) saveUIToUser {

  if (!self.disableSave) {

    // Only set the properties if the value has actually changed.
    // That way, we don't dirty the object and cause a save unnecessarily.
    if ( ![self.user.name isEqual: self.nameTextField.text] ) {
      self.user.name = self.nameTextField.text;
    }

    if ( ![self.user.phoneNumber isEqual: self.phoneTextField.text] ) {
      self.user.phoneNumber = self.phoneTextField.text;
    }

    if ( ![self.user.email isEqual: self.emailTextField.text] ) {
      self.user.email = self.emailTextField.text;
    }

  }

}


// Get ready to segue to the property detail view controller.
- (void)prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender {

  if ( [[segue destinationViewController] isKindOfClass: [NewPropertyViewController class]] ) {

    NewPropertyViewController * propertyVC = (NewPropertyViewController *) [segue destinationViewController];

    if (sender == self.navigationItem.rightBarButtonItem) {

      // The right bar button item is the Add Property button, so create a new property.
      Property * newProperty = [Property object];
      newProperty.landlordId = self.user.objectId;

      propertyVC.property = newProperty;

    } else {

      // TODO: Eventually we will segue to display an *existing* property, in which case
      // we have to fetch that property object and stuff it into the destination VC.
      NSLog(@"Unknown segue sender!");

    }

  } else {

    NSLog(@"Unknown destination VC!");

  }

}


- (IBAction)logoutButtonPressed:(UIBarButtonItem *)sender {

  [PFUser logOutInBackgroundWithBlock: ^ (NSError * _Nullable error) {

    [[NSOperationQueue mainQueue] addOperationWithBlock: ^ {
      self.tabBarController.selectedIndex = 0;
    }];

  }];

}


#pragma mark - PFLogInViewControllerDelegate

- (void) logInViewController: (PFLogInViewController *) logInController didLogInUser: (PFUser *) user {

  // Dismiss the login VC.
  [logInController dismissViewControllerAnimated:true completion: ^ {

    self.user = [User currentUser];
    if (self.user) {

      // Populate the UI from the user object.
      [self loadUIFromUser];

    } else {

      // We still don't have a logged-in user. Go back to the other tab.
      self.tabBarController.selectedIndex = 0;

    }

  }];

}


- (void) logInViewControllerDidCancelLogIn: (PFLogInViewController *) logInController {

  // Dismiss the login VC.
  [logInController dismissViewControllerAnimated:true completion: ^ {
    
    // We still don't have a logged-in user. Go back to the other tab.
    self.tabBarController.selectedIndex = 0;
    
  }];
  
}

@end
