//
//  MOGlossaryMasterViewController.m
//  Meet Options
//
//  Created by The Wynn's  on 7/11/14.
//  Copyright (c) 2014 Optionvesting, LLC. All rights reserved.
//

#import "MOGlossaryMasterViewController.h"
#import "MOGlossaryDetailViewController.h"

@interface MOGlossaryMasterViewController ()

@end

@implementation MOGlossaryMasterViewController

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


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
    // Do any additional setup after loading the view.
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    self.navigationController.navigationBar.tintColor = UIColorFromRGB(0xF2B019);
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"grey-bg.jpg"]]];
    // fill the array with text from a .plist
    self.termsPath = [[NSBundle mainBundle] pathForResource:@"glossarytermslist" ofType:@"plist"];
    self.termsArray = [NSArray arrayWithContentsOfFile:self.termsPath];
     
    // This will fill the array manually
    //self.termsArray = [NSArray arrayWithObjects:@"ask", @"bid", @"close", @"market maker", nil];
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
 cell.textLabel.font = [UIFont fontWithName:@"NeutraDisp-Medium" size:25];
 return cell;
 }

 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 
/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
//    if ([[segue identifier] isEqualToString:@"showGlossaryDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *term = self.termsArray[indexPath.row];
        //NSString *termDefinitionPath = [term stringByAppendingString:@".html"];
        [[segue destinationViewController] setDetailItem:term];
//    }
}


@end

