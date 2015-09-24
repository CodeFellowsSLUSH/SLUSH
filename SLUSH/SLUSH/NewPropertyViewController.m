//
//  NewPropertyViewController.m
//  SLUSH
//
//  Created by Benjamin Laddin on 9/21/15.
//  Copyright © 2015 Chris Budro, Benjamin Laddin, Stephen Lardieri, and Mark Lin. All rights reserved.
//

#import "NewPropertyViewController.h"

#import "CustomTableView.h"


@interface NewPropertyViewController () <UITableViewDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *detailsTextView;
@property (weak, nonatomic) IBOutlet UITableViewCell *descriptionCell;

@end

@implementation NewPropertyViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.tableView.rowHeight = UITableViewAutomaticDimension;
  self.tableView.estimatedRowHeight = 100.0;
  self.tableView.delegate = self;

  self.detailsTextView.delegate = self;

}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
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


@end
