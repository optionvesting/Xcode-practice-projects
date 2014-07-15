//
//  MOTutorialsMasterViewController.m
//  Meet Options
//
//  Created by The Wynn's  on 7/11/14.
//  Copyright (c) 2014 Optionvesting, LLC. All rights reserved.
//

//#import "MOTutorialsMasterViewController.h"
//#import "MOTutorialsDetailViewController.h"
//
//
//@interface MOTutorialsMasterViewController ()
//
//@end
//
//@implementation MOTutorialsMasterViewController
//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    
//    // fill the array with text from a .plist
//    self.firstPath = [[NSBundle mainBundle] pathForResource:@"investingbasicslist" ofType:@"plist"];
//    self.firstArray = [NSArray arrayWithContentsOfFile:self.firstPath];
//    self.secondPath = [[NSBundle mainBundle] pathForResource:@"optionconceptslist" ofType:@"plist"];
//    self.secondArray = [NSArray arrayWithContentsOfFile:self.secondPath];
//    self.thirdPath = [[NSBundle mainBundle] pathForResource:@"optionstrategylist" ofType:@"plist"];
//    self.thirdArray = [NSArray arrayWithContentsOfFile:self.thirdPath];
//    self.fourthPath = [[NSBundle mainBundle] pathForResource:@"makingtradeslist" ofType:@"plist"];
//    self.fourthArray = [NSArray arrayWithContentsOfFile:self.fourthPath];
//    // This will fill the array manually
//    //self.lessonsArray = [NSArray arrayWithObjects:@"ask", @"bid", @"close", @"market maker", nil];
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//#pragma mark - Table View
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    
//    return 4;
//}
//
//- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    // set title of section here
//    if (section == 0) return @"Investing Basics";
//    else if (section ==1) return @"Option Concepts";
//    else if (section ==2) return @"Option Strategy";
//    else if (section ==3) return @"Making Trades";
//    else return @"";
//}
//
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    if (self.count == 0)
//    {
//    self.lesson = self.firstArray[indexPath.row];
//    }
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    cell.textLabel.text = self.lesson;
//    cell.textLabel.font = [UIFont fontWithName:@"NeutraDisp-Bold" size:20];
////    self.firstPath = [[NSBundle mainBundle] pathForResource:@"optionconceptslist" ofType:@"plist"];
//    return cell;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    if (section == 0) return self.firstArray.count;
//    else if (section ==1) return self.secondArray.count;
//    else if (section ==2) return self.thirdArray.count;
//    else if (section ==3) return self.fourthArray.count;
//    else return 0;
//    
//}
//
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}
//
///*
// // Override to support rearranging the table view.
// - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
// {
// }
// */
//
///*
// // Override to support conditional rearranging of the table view.
// - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
// {
// // Return NO if you do not want the item to be re-orderable.
// return YES;
// }
// */
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([[segue identifier] isEqualToString:@"showTutorialsDetail"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        NSString *lesson = self.firstArray[indexPath.row];
//        //NSString *lessonDefinitionPath = [lesson stringByAppendingString:@".html"];
//        [[segue destinationViewController] setDetailItem:lesson];
//    }
//}
//
//
//@end

#import "MOTutorialsMasterViewController.h"
#import "MOTutorialsDetailViewController.h"

// 1
#import "RageIAPHelper.h"
#import <StoreKit/StoreKit.h>

// Add new instance variable to class extension
NSNumberFormatter * _priceFormatter;
// 2
@interface MOTutorialsMasterViewController () {
    NSArray *_products;
}
@end

@implementation MOTutorialsMasterViewController

// 3
- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.title = @"In App Rage";
    
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
    cell.textLabel.font = [UIFont fontWithName:@"NeutraDisp-Bold" size:20];

    
    if ([[RageIAPHelper sharedInstance] productPurchased:product.productIdentifier]) {
        //cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.accessoryView = nil;
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
        cell.userInteractionEnabled = NO;
        cell.textLabel.enabled = NO;
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


@end