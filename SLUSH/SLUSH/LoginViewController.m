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

#import "User.h"


@interface LoginViewController () <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@end


@implementation LoginViewController

- (void) loadView {

  NSLog(@"LoginViewController loadView");

  self.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsSignUpButton | PFLogInFieldsLogInButton | PFLogInFieldsDismissButton;

  [super loadView];

}


- (void)viewDidLoad {

  [super viewDidLoad];

  NSLog(@"LoginViewController viewDidLoad");

  // In order to allow new users to sign up, we have to create a sign-up VC and provide it
  // to the login VC now, even if it never gets used.
  PFSignUpViewController *signUpVC = [[PFSignUpViewController alloc] init];

  signUpVC.fields = PFSignUpFieldsUsernameAndPassword | PFSignUpFieldsEmail | PFSignUpFieldsSignUpButton | PFSignUpFieldsDismissButton;
  signUpVC.delegate = self;

  self.signUpController = signUpVC;

  // Install our custom logo.
  UILabel * loginLogo = [[UILabel alloc] initWithFrame: CGRectMake(0.0, 0.0, 100.0, 100.0)];
  loginLogo.text = @"S.L.U.S.H.";
  self.logInView.logo = loginLogo;

  UILabel * signupLogo = [[UILabel alloc] initWithFrame: CGRectMake(0.0, 0.0, 100.0, 100.0)];
  signupLogo.text = @"S.L.U.S.H.";
  self.signUpController.signUpView.logo = signupLogo;

}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


#pragma mark - Helpers

// Factor out some common logic for handling both new users and existing users.
- (void) handleSuccessfulLogIn: (PFUser *) user {

  NSLog(@"%@ is now logged in", user.username);

  // Dismiss ourselves.
  [self dismissViewControllerAnimated:true completion: nil];

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
