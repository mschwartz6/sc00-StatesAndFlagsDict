//
//  SearchResultsTableViewController.m
//  sc00-StatesAndFlags
//
//  Created by user on 11/13/17.
//  Copyright © 2017 COP2654. All rights reserved.
//

#import "SearchResultsTableViewController.h"
#import "StateDetailViewController.h"
#import "States.h"
#import "StatesTablleViewController.h"
@interface SearchResultsTableViewController ()<UISearchControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate>{
    States *aState;
}

@end

@implementation SearchResultsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hasSelected = false;
    
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.searchController.searchBar.hidden = false;
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

    return [self.searchResults count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchResultsCell" forIndexPath:indexPath];
    
    
    cell.textLabel.text = self.searchResults[indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    self.hasSelected = true;
}

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
        self.searchController.searchBar.hidden = true;
    }
    
}
-(IBAction)unWindAction:(UIStoryboardSegue *)unWindSegue
{
    
    
    
}


@end
