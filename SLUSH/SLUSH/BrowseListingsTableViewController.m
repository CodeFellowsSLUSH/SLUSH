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


@interface BrowseListingsTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *photoArray;

@property (strong, nonatomic) NSArray *colorsArray;


@property (strong, nonatomic) IBOutlet UITableView *browserTabelView;

@end

@implementation BrowseListingsTableViewController


-(void)loadView{
  [super loadView];

}

-(void)viewDidLoad{
  [super viewDidLoad];
  
  self.colorsArray = @[[UIColor blueColor], [UIColor grayColor], [UIColor yellowColor]];
  
  self.tableView.estimatedRowHeight = 100;
  self.tableView.rowHeight = UITableViewAutomaticDimension;
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
  
  cell.headerLabel.text = property.headline;
  cell.descriptionLabel.text = property.propertyDescription;
  
  return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
  return 1;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(BrowseListingCellsTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

  [cell setCollectionViewDataSourceDelegate:self indexPath:indexPath];
  
}

-(NSInteger)collectionView:(ImageCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  
  Property *property = self.properties[collectionView.indexPath.row];
  return property.photos.count;
}

-(UICollectionViewCell *)collectionView:(ImageCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellIdentifier forIndexPath:indexPath];

  Property *property = self.properties[collectionView.indexPath.row];
  
  UIImage *image = property.photos[indexPath.row];
  cell.imageView.image = image;

  return cell;
}

@end

