//
//  IADViewController.m
//  InAppDemo
//
//  Created by The Wynn's  on 7/12/14.
//  Copyright (c) 2014 Optionvesting, LLC. All rights reserved.
//

#import "IADViewController.h"

@interface IADViewController ()

@end

@implementation IADViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _purchaseController = [[PurchaseViewController alloc]init];
    
    [[SKPaymentQueue defaultQueue]
     addTransactionObserver:_purchaseController];
}

- (IBAction)purchaseItem:(id)sender {
    
    _purchaseController.productID =
    @"com.optionvesting.optionpro.themarketmaker";
    
    [self.navigationController
     pushViewController:_purchaseController animated:YES];
    
    [_purchaseController getProductInfo: self];
}

-(void)enableLevel2
{
    _level2Button.enabled = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
