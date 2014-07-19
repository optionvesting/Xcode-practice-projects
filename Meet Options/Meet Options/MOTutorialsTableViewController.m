//
//  MOTutorialsTableViewController.m
//  Meet Options
//
//  Created by The Wynn's  on 7/15/14.
//  Copyright (c) 2014 Optionvesting, LLC. All rights reserved.
//

#import "MOTutorialsTableViewController.h"
#import "MOTutorialsDetailViewController.h"

@interface MOTutorialsTableViewController ()

@property (strong,nonatomic) id tempDetail;

@end

@implementation MOTutorialsTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil]; 
    self.title = self.detailItem;
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"grey-bg.jpg"]]];

    // Do any additional setup after loading the view.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    // fill the array with text from a .plist
    self.termsPath = [[NSBundle mainBundle] pathForResource:self.detailItem ofType:@"plist"];

    NSLog(@"detailItem is %@", self.detailItem);
    NSLog(@"termsPath is %@", self.termsPath);

    self.termsArray = [NSArray arrayWithContentsOfFile:self.termsPath];

    
    
    // This will fill the array manually
//    self.termsArray = [NSArray arrayWithObjects:@"ask", @"bid", @"close", @"market maker", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.termsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSString *term = self.termsArray[indexPath.row];
    cell.textLabel.text = term;
    cell.detailTextLabel.text = @"HTML";
    cell.textLabel.font = [UIFont fontWithName:@"NeutraDisp-Bold" size:20];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    //    if ([[segue identifier] isEqualToString:@"showGlossaryDetail"]) {

    //NSString *termDefinitionPath = [term stringByAppendingString:@".html"];
    [[segue destinationViewController] setDetail:self.tempDetail];
    
    //    }


}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // Get selected lesson group
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//    SKProduct * product = (SKProduct *) _products[indexPath.row];
//    
//    if ([[RageIAPHelper sharedInstance] productPurchased:product.productIdentifier]) {
//        
//        [self performSegueWithIdentifier:cell.textLabel.text sender:self];
//        
//    }

   // Perform Segue
    self.tempDetail = cell.textLabel.text;

        [self performSegueWithIdentifier:@"showTutorialsDetail" sender:self];
}

//
//
//
@end