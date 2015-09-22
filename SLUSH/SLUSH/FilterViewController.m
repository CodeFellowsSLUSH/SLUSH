//
//  FilterViewController.m
//  SLUSH
//
//  Created by Benjamin Laddin on 9/21/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import "FilterViewController.h"
#import "PropertyQueryFilter.h"

@interface FilterViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *bedroomSegmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *bathroomSegmentedControl;
@property (weak, nonatomic) IBOutlet UITableViewCell *resetFiltersCell;

@end

@implementation FilterViewController


#pragma mark - Life Cycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
  
  if (self.filter) {
    [self updateFilter];
  } else {
    self.filter = [[PropertyQueryFilter alloc] init];
  }
  
  UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelWasPressed)];
  self.navigationItem.leftBarButtonItem = cancelButton;
  
  UIBarButtonItem * applyFilterButton = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(applyFilterWasPressed)];
  self.navigationItem.rightBarButtonItem = applyFilterButton;
  
  
}


- (void)updateFilter {
  self.bedroomSegmentedControl.selectedSegmentIndex = self.filter.minBedrooms;
  self.bathroomSegmentedControl.selectedSegmentIndex = self.filter.minBathrooms;
}


#pragma mark - Actions
- (IBAction)bedroomSegmentWasChanged:(UISegmentedControl *)sender {
  self.filter.minBedrooms = sender.selectedSegmentIndex;
}

- (IBAction)bathroomSegmentWasChanged:(UISegmentedControl *)sender {
  self.filter.minBathrooms = sender.selectedSegmentIndex;
}


- (void)cancelWasPressed {
  [self.navigationController popViewControllerAnimated:true];
}

- (void)applyFilterWasPressed {
  [self.delegate filterManager:self didApplyFilter:self.filter];
}

#pragma mark - Table View Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *currentCell = [tableView cellForRowAtIndexPath:indexPath];
  if (currentCell == self.resetFiltersCell) {
    self.filter = [[PropertyQueryFilter alloc] init];
  }
}

@end
