//
//  NewPropertyViewController.m
//  SLUSH
//
//  Created by Benjamin Laddin on 9/21/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import "NewPropertyViewController.h"

#import "CustomTableView.h"
#import "Property.h"
#import "LocationSearchResultsController.h"
#import "GooglePlaceService.h"


@interface NewPropertyViewController () <UITableViewDelegate, UITextViewDelegate, UISearchResultsUpdating, LocationPickerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *headlineTextField;
@property (weak, nonatomic) IBOutlet UITextView *detailsTextView;
@property (weak, nonatomic) IBOutlet UITableViewCell *descriptionCell;

@property (weak, nonatomic) IBOutlet UITextField *rentTextField;

@property (weak, nonatomic) IBOutlet UISlider *leaseTermSlider;
@property (weak, nonatomic) IBOutlet UILabel *leaseTermLabel;

@property (weak, nonatomic) IBOutlet UITextField *sqFtTextField;
@property (weak, nonatomic) IBOutlet UITextField *bedsTextField;
@property (weak, nonatomic) IBOutlet UITextField *bathsTextField;

@property (weak, nonatomic) IBOutlet UISwitch *petsSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *smokingSwitch;

@property (weak, nonatomic) IBOutlet UISwitch *wdSwitch;
@property (weak, nonatomic) IBOutlet UITableViewCell *addressSearchCell;

@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) LocationSearchResultsController *searchResultsController;


@end

@implementation NewPropertyViewController


- (void)viewDidLoad {
  [super viewDidLoad];

  // Configure table view for dynamic row height.
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  self.tableView.estimatedRowHeight = 100.0;
  self.tableView.delegate = self;

  // Capture changes to the Details text, so we can adjust the height of that cell on the fly
  // as lines are added or deleted in the text.
  self.detailsTextView.delegate = self;

  // Populate the UI from the property object.
  NSAssert(self.property && self.property.landlordId, @"You must supply a property object with a link to a landlord's user object");
  [self loadUIFromProperty];
  
  [self setupSearchController];

}


- (void) loadUIFromProperty {

  self.headlineTextField.text = self.property.headlineDescription;
  self.detailsTextView.text = self.property.detailsDescription;

  self.rentTextField.text = (self.property.price > 0) ? [NSString stringWithFormat: @"%ld", (long)self.property.price] : @"";

  self.leaseTermSlider.value = self.property.monthsAvailable;

  self.sqFtTextField.text = (self.property.squareFeet > 0) ? [NSString stringWithFormat: @"%ld", (long)self.property.squareFeet] : @"";
  self.bedsTextField.text = (self.property.numberOfBedrooms > 0) ? [NSString stringWithFormat: @"%ld", (long)self.property.numberOfBedrooms] : @"";
  self.bathsTextField.text = (self.property.numberOfBathrooms > 0) ? [NSString stringWithFormat: @"%ld", (long)self.property.numberOfBathrooms] : @"";

  self.petsSwitch.on = self.property.allowsPets;
  self.smokingSwitch.on = self.property.allowsSmoking;

  self.wdSwitch.on = self.property.hasWasherDryer;

}

- (void) saveUIToProperty {

  self.property.headlineDescription = self.headlineTextField.text;
  self.property.detailsDescription = self.detailsTextView.text;

  self.property.price = [self.rentTextField.text integerValue];

  self.property.monthsAvailable = self.leaseTermSlider.value;

  self.property.squareFeet = [self.sqFtTextField.text integerValue];
  self.property.numberOfBedrooms = [self.bedsTextField.text integerValue];
  self.property.numberOfBathrooms = [self.bathsTextField.text integerValue];

  self.property.allowsPets = self.petsSwitch.on;
  self.property.allowsSmoking = self.smokingSwitch.on;

  self.property.hasWasherDryer = self.wdSwitch.on;

}

- (void)setupSearchController {
  self.searchResultsController = [[LocationSearchResultsController alloc] initWithStyle:UITableViewStylePlain];
  self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchResultsController];
  self.searchController.searchResultsUpdater = self;
  self.searchResultsController.delegate = self;
  
  [self.addressSearchCell addSubview:self.searchController.searchBar];
 
}


- (CGFloat) tableView: (UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return UITableViewAutomaticDimension;
}


- (CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return UITableViewAutomaticDimension;
}


- (void)textViewDidChange:(UITextView *)textView {

  // Temporarily disable animations and ignore changes to the .bounds property.
  CustomTableView * customTableView = (CustomTableView *) self.tableView;
  [customTableView ignoreAnimationsAndBoundsChanges: true];

  // "Move" the cell with the description's text view to the same position that it's already in.
  // This forces the table view to re-evaluate the height of the cell, which may have changed if the text view
  // added or deleted a line; and if there has, in fact, been a change, then move the other cells up or down as needed
  // to make room or fill in the gap.
  // Unfortunately, the table view then tries to scroll the current cell as low on the screen as it can go,
  // which is quite annoying when you are in the middle of typing.
  // That is why we have to disable animations and ignore changes to the .bounds property.
  NSIndexPath * indexPath = [self.tableView indexPathForCell: self.descriptionCell];
  [self.tableView moveRowAtIndexPath: indexPath toIndexPath: indexPath];

  // Re-enable animations and ignore changes to the .bounds property.
  [customTableView ignoreAnimationsAndBoundsChanges: false];

}

#pragma mark - Search Results Updating

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
  [picker dismissViewControllerAnimated:true completion:nil];
 
  self.property.coordinate = place.coordinate;
  self.property.streetAddress = place.attributions.string;
}




@end
