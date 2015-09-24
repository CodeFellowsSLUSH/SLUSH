//
//  FilterViewController.m
//  SLUSH
//
//  Created by Benjamin Laddin on 9/21/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import "FilterViewController.h"
#import "PropertyQueryFilter.h"
#import "GooglePlaceService.h"
#import "LocationSearchResultsController.h"
#import "PriceRangePickerDataSource.h"
#import "Constants.h"

@interface FilterViewController ()

#pragma mark - Outlets
@property (weak, nonatomic) IBOutlet UISegmentedControl *bedroomSegmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *bathroomSegmentedControl;
@property (weak, nonatomic) IBOutlet UITableViewCell *resetFiltersCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *useCurrentLocationCell;
@property (weak, nonatomic) IBOutlet UIPickerView *priceRangePicker;

#pragma mark - Properties
@property (strong, nonatomic) PriceRangePickerDataSource *priceRangePickerDataSource;
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) LocationSearchResultsController *searchResultsController;

@end

@implementation FilterViewController


#pragma mark - Life Cycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
  
  self.priceRangePicker.dataSource = self.priceRangePickerDataSource;
  self.priceRangePicker.delegate = self.priceRangePickerDataSource;
  
  UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelWasPressed)];
  self.navigationItem.leftBarButtonItem = cancelButton;
  
  UIBarButtonItem * applyFilterButton = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(applyFilterWasPressed)];
  self.navigationItem.rightBarButtonItem = applyFilterButton;
  
  self.searchResultsController = [[LocationSearchResultsController alloc] initWithStyle:UITableViewStylePlain];
  self.searchResultsController.delegate = self;
  
  self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchResultsController];

  self.tableView.tableHeaderView = self.searchController.searchBar;
  self.searchController.searchBar.placeholder = @"Current Location";
  self.searchController.searchResultsUpdater = self;
}

-(void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  if (self.filter) {
    [self updateFilterDisplay];
  } else {
    self.filter = [[PropertyQueryFilter alloc] init];
  }
}


- (void)updateFilterDisplay {
  self.bedroomSegmentedControl.selectedSegmentIndex = self.filter.minBedrooms.integerValue;
  self.bathroomSegmentedControl.selectedSegmentIndex = self.filter.minBathrooms.integerValue;
  self.searchController.searchBar.text = self.filter.searchNearPlace.name;
  
  NSInteger minRow = [self.priceRangePickerDataSource.minPrices indexOfObject:self.filter.minPrice];
  [self.priceRangePicker selectRow:minRow inComponent:kMinRentComponent animated:true];
  
  NSInteger maxRow = [self.priceRangePickerDataSource.maxPrices indexOfObject: self.filter.maxPrice];
  [self.priceRangePicker selectRow:maxRow inComponent:kMaxRentComponent animated:true];
  
}


#pragma mark - Actions
- (IBAction)bedroomSegmentWasChanged:(UISegmentedControl *)sender {
  self.filter.minBedrooms = [NSNumber numberWithLong:sender.selectedSegmentIndex];
}

- (IBAction)bathroomSegmentWasChanged:(UISegmentedControl *)sender {
  self.filter.minBathrooms = [NSNumber numberWithLong:sender.selectedSegmentIndex];
}


- (void)cancelWasPressed {
  [self.navigationController popViewControllerAnimated:true];
}

- (void)applyFilterWasPressed {
  NSInteger minPriceRow = [self.priceRangePicker selectedRowInComponent:kMinRentComponent];
  NSInteger maxPriceRow = [self.priceRangePicker selectedRowInComponent:kMaxRentComponent];
  
  NSNumber *minPrice = [self.priceRangePickerDataSource minPriceForRow:minPriceRow];
  NSNumber *maxPrice = [self.priceRangePickerDataSource maxPriceForRow:maxPriceRow];

  self.filter.minPrice = minPrice;
  self.filter.maxPrice = maxPrice;

  [self.delegate filterManager:self didApplyFilter:self.filter];
}

- (void)resetFilters {
  self.filter = [[PropertyQueryFilter alloc] init];
  [self updateFilterDisplay];
}



#pragma mark - Table View Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *currentCell = [tableView cellForRowAtIndexPath:indexPath];
  if (currentCell == self.resetFiltersCell) {
    [self resetFilters];
    [tableView deselectRowAtIndexPath:indexPath animated:true];
  } else if (currentCell == self.useCurrentLocationCell) {
    
  }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  if (cell == self.resetFiltersCell || cell == self.useCurrentLocationCell) {
    return true;
  }
  return false;
}

#pragma mark - Search Results updating

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
  [GooglePlaceService autoCompletePredictionsFromSearchTerm:searchController.searchBar.text withBlock:^(NSArray *predictions, NSError *error) {
    if (error) {
      
    } else {
      self.searchResultsController.searchResults = predictions;
    }
  }];
}

#pragma mark - Location Picker Delegate

-(void)locationPicker:(LocationSearchResultsController *)picker didPickPlace:(GMSPlace *)place {
  self.filter.searchNearPlace = place;
  [self updateFilterDisplay];
  [self.searchResultsController dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - Getters / Setters

-(void)setFilter:(PropertyQueryFilter *)filter {
  _filter = filter;
}

-(PriceRangePickerDataSource *)priceRangePickerDataSource {
  if (!_priceRangePickerDataSource) {
    _priceRangePickerDataSource = [[PriceRangePickerDataSource alloc] init];
  }
  return _priceRangePickerDataSource;
}

@end
