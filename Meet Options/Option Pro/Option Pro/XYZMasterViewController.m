//
//  XYZMasterViewController.m
//  Option Pro
//
//  Created by The Wynn's  on 7/14/14.
//  Copyright (c) 2014 Optionvesting, LLC. All rights reserved.
//
#import "XYZMasterViewController.h"
#import "XYZDetailViewController.h"

// 1
#import "RageIAPHelper.h"
#import <StoreKit/StoreKit.h>

// Add new instance variable to class extension
NSNumberFormatter * _priceFormatter;

// 2
@interface XYZMasterViewController () {
    NSArray *_products;
}
@end

@implementation XYZMasterViewController

// 3
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"In App Rage";
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(reload) forControlEvents:UIControlEventValueChanged];
    [self reload];
    [self.refreshControl beginRefreshing];
    _priceFormatter = [[NSNumberFormatter alloc] init];
    [_priceFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [_priceFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Restore" style:UIBarButtonItemStyleBordered target:self action:@selector(restoreTapped:)];
    
}

// 4
- (void)reload {
    _products = nil;
    [self.tableView reloadData];
    [[RageIAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
        if (success) {
            _products = products;
            [self.tableView reloadData];
        }
        [self.refreshControl endRefreshing];
    }];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



// 5
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    SKProduct * product = (SKProduct *) _products[indexPath.row];
    cell.textLabel.text = product.localizedTitle;

    if ([[RageIAPHelper sharedInstance] productPurchased:product.productIdentifier]) {
        //cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.accessoryView = nil;
        self.shouldSegueOccur = YES;
        cell.detailTextLabel.text = @"";

    } else {
        [_priceFormatter setLocale:product.priceLocale];
        cell.detailTextLabel.text = [_priceFormatter stringFromNumber:product.price];
        UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        buyButton.frame = CGRectMake(0, 0, 72, 37);
        [buyButton setTitle:@"Buy" forState:UIControlStateNormal];
        buyButton.tag = indexPath.row;
        [buyButton addTarget:self action:@selector(buyButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.accessoryView = buyButton;
        self.shouldSegueOccur = NO;
    }
    
    
        return cell;
}

- (void)buyButtonTapped:(id)sender {
    
    UIButton *buyButton = (UIButton *)sender;
    SKProduct *product = _products[buyButton.tag];
    
    NSLog(@"Buying %@...", product.productIdentifier);
    [[RageIAPHelper sharedInstance] buyProduct:product];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:IAPHelperProductPurchasedNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)productPurchased:(NSNotification *)notification {
    
    NSString * productIdentifier = notification.object;
    [_products enumerateObjectsUsingBlock:^(SKProduct * product, NSUInteger idx, BOOL *stop) {
        if ([product.productIdentifier isEqualToString:productIdentifier]) {
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            *stop = YES;
        }
    }];
    
}

- (void)restoreTapped:(id)sender {
    [[RageIAPHelper sharedInstance] restoreCompletedTransactions];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"showDetail"]) {
        if (self.shouldSegueOccur == NO) {
//            UIAlertView *notPermitted = [[UIAlertView alloc]
//                                         initWithTitle:@"Alert"
//                                         message:@"Segue not permitted (better message here)"
//                                         delegate:nil
//                                         cancelButtonTitle:@"OK"
//                                         otherButtonTitles:nil];
            
            NSLog(@"Segue Blocked");

            
            // prevent segue from occurring
            return NO;
        }
    }
        //Put your validation code here and return YES or NO as needed
        NSLog(@"Segue Allowed");

        return YES;
    
}

@end