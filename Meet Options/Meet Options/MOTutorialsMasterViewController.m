//
//  MOTutorialsMasterViewController.m
//  Meet Options
//
//  Created by The Wynn's  on 7/11/14.
//  Copyright (c) 2014 Optionvesting, LLC. All rights reserved.
//

#import "MOTutorialsMasterViewController.h"
#import "MOTutorialsDetailViewController.h"


@interface MOTutorialsMasterViewController ()

@end

@implementation MOTutorialsMasterViewController

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
    
    // fill the array with text from a .plist
    self.firstPath = [[NSBundle mainBundle] pathForResource:@"investingbasicslist" ofType:@"plist"];
    self.firstArray = [NSArray arrayWithContentsOfFile:self.firstPath];
    self.secondPath = [[NSBundle mainBundle] pathForResource:@"optionconceptslist" ofType:@"plist"];
    self.secondArray = [NSArray arrayWithContentsOfFile:self.secondPath];
    self.thirdPath = [[NSBundle mainBundle] pathForResource:@"optionstrategylist" ofType:@"plist"];
    self.thirdArray = [NSArray arrayWithContentsOfFile:self.thirdPath];
    self.fourthPath = [[NSBundle mainBundle] pathForResource:@"makingtradeslist" ofType:@"plist"];
    self.fourthArray = [NSArray arrayWithContentsOfFile:self.fourthPath];
    // This will fill the array manually
    //self.lessonsArray = [NSArray arrayWithObjects:@"ask", @"bid", @"close", @"market maker", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 4;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // set title of section here
    if (section == 0) return @"Investing Basics";
    else if (section ==1) return @"Option Concepts";
    else if (section ==2) return @"Option Strategy";
    else if (section ==3) return @"Making Trades";
    else return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return self.firstArray.count;
    else if (section ==1) return self.secondArray.count;
    else if (section ==2) return self.thirdArray.count;
    else if (section ==3) return self.fourthArray.count;
    else return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        NSString *lesson = self.firstArray[indexPath.row];
        cell.textLabel.text = lesson;
        cell.textLabel.font = [UIFont fontWithName:@"NeutraDisp-Bold" size:20];
//    self.firstPath = [[NSBundle mainBundle] pathForResource:@"optionconceptslist" ofType:@"plist"];
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
    if ([[segue identifier] isEqualToString:@"showTutorialsDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *lesson = self.firstArray[indexPath.row];
        //NSString *lessonDefinitionPath = [lesson stringByAppendingString:@".html"];
        [[segue destinationViewController] setDetailItem:lesson];
    }
}


@end

