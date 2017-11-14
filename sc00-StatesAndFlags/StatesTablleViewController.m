//
//  StatesTablleViewController.m
//  sc00-StatesAndFlags
//
//  Created by Entec Department on 11/2/16.
//  Copyright © 2016 COP2654. All rights reserved.
//

#import "StatesTablleViewController.h"
#import "States.h"
#import "StateTableViewCell.h"
#import "StateDetailViewController.h"
#import "SearchResultsTableViewController.h"
@interface StatesTablleViewController ()<UISearchResultsUpdating,UISearchControllerDelegate,UITableViewDelegate>
@property(nonatomic, strong)NSMutableArray *searchResults;
@end

@implementation StatesTablleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"US-States" ofType:@"plist"];
    
    // load the content of the plist into device memory through a dictionary data structure
    self.states = [[NSDictionary alloc]initWithContentsOfFile:path];
    
    self.keys = [[self.states allKeys]sortedArrayUsingSelector:@selector(compare:)];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //Grab the newly added navigation controller via its storyboard ID
    UINavigationController *searchResultsController = [[self storyboard]instantiateViewControllerWithIdentifier:@"TableSearchResultsNavigationController"];
    self.searchController = [[UISearchController  alloc]initWithSearchResultsController:searchResultsController];
    //search results protocol
    self.searchController.searchResultsUpdater = self;
    //self.searchController.definesPresentationContext = true;
    //add search bar programmatically....
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44);
    
    //where we want to put the search bar
    self.tableView.tableHeaderView =self.searchController.searchBar;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.keys count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"stateInfoCell";
    StateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // populate cells with data
    NSString *key = [self.keys objectAtIndex:indexPath.row];
    cell.stateName.text = self.states[key][@"Names"];
    cell.stateMotto.text = self.states[key][@"Motto"];
                            
    cell.flagImageView.image = [UIImage imageNamed:self.states[key][@"FlagIcon"]];
    
    return cell;
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier]isEqualToString:@"showDetail"]){
        StateDetailViewController *destinationViewController = [segue destinationViewController];
        
        // get the selection
        NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
        
        States* aState = [[States alloc]init];
    
        NSString *key = [self.keys objectAtIndex:myIndexPath.row];
        
        
        aState.name = self.states[key][@"Name"];
        aState.motto = self.states[key][@"Motto"];
        aState.flag = [UIImage imageNamed:self.states[key][@"FlagImage"]];
        
        // Pass the selected object to the new view controller.
        destinationViewController.myState = aState;
        
    }
    
    }




-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchString = self.searchController.searchBar.text;
   // NSLog (@"User search typed: %@",searchString);
    //call helper method
    [self updateFilteredContentForStateName:searchString];
    if (self.searchController.searchResultsController)
    {
        UINavigationController *navController =(UINavigationController*)self.searchController.searchResultsController;
        //present search results table view as top view ...
        SearchResultsTableViewController *vc = (SearchResultsTableViewController *)navController.topViewController;
        //update vc
        vc.searchResults = self.searchResults;
        vc.states = self.states;
        vc.keys = self.keys;
        vc.searchController = self.searchController;
        //reload table view with new data
        
        [vc.tableView reloadData];
        
        
        
    }
}
//helper
-(void)updateFilteredContentForStateName:(NSString *)stateName
{
    //NSLog(@"DEBUG recieved: %@",stateName);
    if (stateName == nil)
    {
        //empty search results, pass original array
        self.searchResults = [self.keys mutableCopy];
    }
    else
    {
        //loop through dictionary to see if its a match
        //if found add object to ssearchResults array
        NSMutableArray *searchResults = [[NSMutableArray alloc]init];
        for (id key in self.states)
        {
            //get all of them
            NSDictionary *myValues = [self.states objectForKey:key];
           // NSLog (@"Values are : %@",myValues);
            //fitering
            if ([myValues[@"Name"] containsString:stateName])
            {
                NSString *state = [NSString stringWithFormat:@"%@",myValues[@"Name"]];
                [searchResults addObject:state];
            }
            self.searchResults = searchResults;
        }
        
    }
}



-(void)comeOnAssignIt:(NSIndexPath *)indexPath{
    
    NSString *key = [self.keys objectAtIndex:indexPath.row];
    self.aKey = key;
    //[self performSegueWithIdentifier:@"segFromSearch" sender:self];
}

@end
