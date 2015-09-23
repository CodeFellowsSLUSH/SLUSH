//
//  LocationSearchResultsController.m
//  SLUSH
//
//  Created by Chris Budro on 9/22/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import "LocationSearchResultsController.h"

NSString * const kSearchCellReuseIdentifier = @"Cell";

@implementation LocationSearchResultsController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kSearchCellReuseIdentifier];
  
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (self.searchResults.count == 0) {
    return 1;
  }
  return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSearchCellReuseIdentifier forIndexPath:indexPath];
  
  if (self.searchResults.count > 0) {
    NSString *result = self.searchResults[indexPath.row];
    cell.textLabel.text = @"Test";
  } else {
    cell.textLabel.text = @"Current Location";
  }
  
  
  return cell;
}



@end
