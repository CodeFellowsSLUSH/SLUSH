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
#import "Property.h"
#import "ParseService.h"
#import "Constants.h"
#import "BLDetailedViewController.h"

CGFloat const kCellFadeInDuration = 0.3;

@interface BrowseListingsTableViewController ()<UITableViewDelegate, UITableViewDataSource>

//@property (strong, nonatomic) IBOutlet UITableView *browserTabelView;

@end

@implementation BrowseListingsTableViewController

#pragma mark - Life Cycle Methods
-(void)loadView{
  [super loadView];

}

-(void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewDidLoad{
  [super viewDidLoad];

  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(propertiesDidLoad:) name:kPropertiesDidLoadNotification object:nil];
  
  self.tableView.estimatedRowHeight = 100;
  self.tableView.rowHeight = UITableViewAutomaticDimension;
}

#pragma mark - Helper Methods

- (void)propertiesDidLoad:(NSNotification *)notification {

  NSArray *properties = notification.userInfo[kPropertiesListKey];
  self.properties = properties;
  [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.properties.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  BrowseListingCellsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listingCell" forIndexPath:indexPath];
  
  Property *property = self.properties[indexPath.row];
  
  cell.headerLabel.text = property.headlineDescription;
  cell.descriptionLabel.text = property.detailsDescription;
  cell.priceLabel.text = [NSString stringWithFormat:@"$%ld", (long)property.price];
  
  return cell;
}

#pragma mark - Table View Delegate

-(void)tableView:(UITableView *)tableView willDisplayCell:(BrowseListingCellsTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
  
  cell.collectionView.dataSource = nil;
  [cell.collectionView reloadData];
  [cell setCollectionViewDataSourceDelegate:self indexPath:indexPath];
  
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self performSegueWithIdentifier:@"showBLDetailedVC" sender:self];
  [tableView deselectRowAtIndexPath:indexPath animated:true];
}



#pragma mark - Collection View Data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
  return 1;
}

-(NSInteger)collectionView:(ImageCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  
  Property *property = self.properties[collectionView.indexPath.row];
  return property.photos.count;
}

-(UICollectionViewCell *)collectionView:(ImageCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellIdentifier forIndexPath:indexPath];
  
  Property *property = self.properties[collectionView.indexPath.row];
  PFObject *photo = property.photos[indexPath.row];
  
  cell.imageView.image = nil;
  cell.alpha = 0;
  cell.tag++;
  NSInteger tag = cell.tag;
  
  [ParseService fetchImageObject:photo withBlock:^(UIImage *image, NSError *error) {
    if (!error) {
      if (tag == cell.tag) {
        cell.imageView.image = image;
        [UIView animateWithDuration:kCellFadeInDuration animations:^{
          cell.alpha = 1.0;
        }];
      }


    }
    
  }];

  return cell;
}

#pragma mark - Collection View Flow Layout Delegate

-(CGSize)collectionView:(ImageCollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  
  return collectionView.frame.size;
}


-(void)collectionView:(ImageCollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
  [self performSegueWithIdentifier:@"showBLDetailedVC" sender:collectionView];
  NSLog(@"the collection View Should change");
}

#pragma mark - BLDetailedVC

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  if ([[segue identifier]isEqualToString:@"showBLDetailedVC"]) {
    BLDetailedViewController *bldetailedVC = [segue destinationViewController];
    
    ImageCollectionView *collectionView = sender;
    NSIndexPath *indexPath = collectionView.indexPath;
    
    Property *property = self.properties[indexPath.row];
    
    bldetailedVC.property = property;
    
  }
}



@end

