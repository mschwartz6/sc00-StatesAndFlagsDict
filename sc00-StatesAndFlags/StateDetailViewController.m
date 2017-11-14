//
//  StateDetailViewController.m
//  sc00-StatesAndFlags
//
//  Created by Entec Department on 11/2/16.
//  Copyright © 2016 COP2654. All rights reserved.
//

#import "StateDetailViewController.h"

@interface StateDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *detailFlagImage;
@property (weak, nonatomic) IBOutlet UILabel *detailStateName;
@property (weak, nonatomic) IBOutlet UILabel *detailStateMotto;
@property (weak, nonatomic) IBOutlet UILabel *detailStateCapital;
@property (weak, nonatomic) IBOutlet UILabel *statePopulation;
@property (weak, nonatomic) IBOutlet UILabel *area;

@end

@implementation StateDetailViewController
-(void)viewWillAppear:(BOOL)animated
{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.detailFlagImage.image = _myState.flag;
    self.detailStateName.text = _myState.name;
    self.detailStateMotto.text = _myState.motto;
    self.detailStateCapital.text = _myState.capital;
    
    // add a title to the Details View
    self.navigationItem.title = _myState.name;
    
    
    // add additional information
    if ([_myState.name isEqualToString:@"Alabama"]){
        self.area.text = @"Area: 52,419";
        self.statePopulation.text = @"Population: 4.8 million";
    }
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
