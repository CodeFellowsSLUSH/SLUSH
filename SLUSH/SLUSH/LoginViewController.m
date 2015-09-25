//
//  LoginViewController.m
//  SLUSH
//
//  Created by Stephen Lardieri on 9/24/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import "LoginViewController.h"

#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

#import "UserDataObject.h"


// Magic
static NSString * const kLoginSuccessfulSegue = @"LoginSuccessful";


@interface LoginViewController () <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@end


@implementation LoginViewController

- (void) loadView {

  [super loadView];

  NSLog(@"LoginViewController loadView");

  // Allow log in or sign up, not cancel. If the user wants to cancel, she can just switch back to the other tab.
  self.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsSignUpButton | PFLogInFieldsLogInButton;

}


- (void)viewDidLoad {

  [super viewDidLoad];

  NSLog(@"LoginViewController viewDidLoad");

  // In order to allow new users to sign up, we have to create a sign-up VC and provide it
  // to the login VC now, even if it never gets used.
  PFSignUpViewController *signUpVC = [[PFSignUpViewController alloc] init];

  signUpVC.fields = PFSignUpFieldsUsernameAndPassword | PFSignUpFieldsSignUpButton | PFSignUpFieldsDismissButton;
  signUpVC.delegate = self;

  self.signUpController = signUpVC;

  // Yeah, this is weird...
  self.delegate = self;

  // If we have a cached login from a previous run, go immediately to the next VC.
  PFUser * user = [PFUser currentUser];
  if (user) {
    [self handleSuccessfulLogIn: user];
  }

}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

  // Get the new view controller using [segue destinationViewController].

}


#pragma mark - Helpers

// Factor out some common logic for handling both new users and existing users.
- (void) handleSuccessfulLogIn: (PFUser *) user {

  NSLog(@"%@ is now logged in", user.username);

  // Segue to the post-login view.
  // Always use "self" as the sender, even if we're coming from the sign up VC, so our own prepareForSegue gets called.
  NSLog(@"Login view controller segueing to Profile view controller");
  [self performSegueWithIdentifier: kLoginSuccessfulSegue sender: self];

}


#pragma mark - PFLogInViewControllerDelegate

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {

  [self handleSuccessfulLogIn: user];

}


#pragma mark - PFSignUpViewControllerDelegate

// Handle results of sign-up UI.
- (void) signUpViewController:(PFSignUpViewController * __nonnull)signUpController didFailToSignUpWithError:(nullable NSError *)error {

  // Typical reason: username already exists.
  // Note: the sign-up VC *does not* get dismissed - it is still on-screen so the user can try again.
  NSLog(@"Failed to sign up. Error: %@", error.localizedDescription);

}

- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {

  NSLog(@"Signed up new user %@.", user.username);

  // Get rid of the sign-up VC. It appears to be modal, not nav stack, so use dismiss instead of pop.
  [signUpController dismissViewControllerAnimated:true completion: ^void () {

    // A successful sign up is also a successful log in, so treat it thusly.
    [self handleSuccessfulLogIn: user];
    
  }];
  
}

@end
