//
//  LocationSearchResultsController.m
//  SLUSH
//
//  Created by Chris Budro on 9/22/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import "LocationSearchResultsController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "GooglePlaceService.h"
#import "ErrorAlertController.h"


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
    return self.searchResults.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSearchCellReuseIdentifier forIndexPath:indexPath];
  
  GMSAutocompletePrediction *result = self.searchResults[indexPath.row];
  NSAttributedString *fullText = result.attributedFullText;
  cell.textLabel.attributedText = fullText;
  
  return cell;
}

-(void)setSearchResults:(NSArray *)searchResults {
  _searchResults = searchResults;
  [self.tableView reloadData];
}

#pragma mark - Table View Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  GMSAutocompletePrediction *placePrediction = self.searchResults[indexPath.row];
  
  [GooglePlaceService googlePlaceForAutocompletePrediction:placePrediction withBlock:^(GMSPlace *place, NSError *error) {
    if (error) {
      [self.tableView deselectRowAtIndexPath:indexPath animated:true];
      UIAlertController *alert = [ErrorAlertController alertWithError:error];
      [self presentViewController:alert animated:true completion:nil];
    } else {
    [self.delegate locationPicker:self didPickPlace:place];
    }
  }];
  
  
}

@end
