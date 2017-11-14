//
//  StatesTablleViewController.h
//  sc00-StatesAndFlags
//
//  Created by Entec Department on 11/2/16.
//  Copyright © 2016 COP2654. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatesTablleViewController : UITableViewController
@property(nonatomic, strong)UISearchController *searchController;
@property(nonatomic,strong)NSString *aKey;
@property(nonatomic, strong)NSDictionary *states;
@property(nonatomic, strong)NSArray* keys;
-(void)comeOnAssignIt:(NSIndexPath *)indexPath;
@end
