//
//  SearchResultsTableViewController.h
//  sc00-StatesAndFlags
//
//  Created by user on 11/13/17.
//  Copyright © 2017 COP2654. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultsTableViewController : UITableViewController
@property (nonatomic,strong)NSMutableArray *searchResults;
@property(nonatomic, strong)NSDictionary *states;
@property(nonatomic, strong)NSArray* keys;
@property(nonatomic, strong)UISearchController *searchController;
@property BOOL hasSelected;
@end
