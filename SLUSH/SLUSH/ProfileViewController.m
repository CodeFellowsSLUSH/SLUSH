//
//  ProfileViewController.m
//  SLUSH
//
//  Created by Benjamin Laddin on 9/21/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import "ProfileViewController.h"
#import "LoginViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  LoginViewController *loginViewController = [[LoginViewController alloc] init];
  
  [self.navigationController pushViewController:loginViewController animated:true];
  
}

@end
