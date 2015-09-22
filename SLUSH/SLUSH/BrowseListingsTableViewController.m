//
//  BrowseListingsTableViewController.m
//  SLUSH
//
//  Created by Benjamin Laddin on 9/22/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import "BrowseListingsTableViewController.h"
#import "BrowseListingCellsTableViewCell.h"
#import "ImageCollectionViewCell.h"


@interface BrowseListingsTableViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *browserTabelView;

@end

@implementation BrowseListingsTableViewController

-(void)viewDidLoad{
  [super viewDidLoad];
  
  self.tableView.estimatedRowHeight = 100;
  self.tableView.rowHeight = UITableViewAutomaticDimension;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
  return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  BrowseListingCellsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listingCell" forIndexPath:indexPath];
  cell.headerLabel.text = @"awesome Place is avalible!!!! PETS WELCOME";
  cell.descriptionLabel.text = @"this is a grate place located in SLU washer and dryer included, utilities included, cant miss this opportunity for a great place in the best location";
  
  
  
  
  
  return cell;
  
}

@end

