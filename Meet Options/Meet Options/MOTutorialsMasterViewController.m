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
    self.lessonsPath = [[NSBundle mainBundle] pathForResource:@"tutorialslessonslist" ofType:@"plist"];
    self.lessonsArray = [NSArray arrayWithContentsOfFile:self.lessonsPath];
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lessonsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSString *lesson = self.lessonsArray[indexPath.row];
    cell.textLabel.text = lesson;
    cell.textLabel.font = [UIFont fontWithName:@"NeutraDisp-Bold" size:20];
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
        NSString *lesson = self.lessonsArray[indexPath.row];
        //NSString *lessonDefinitionPath = [lesson stringByAppendingString:@".html"];
        [[segue destinationViewController] setDetailItem:lesson];
    }
}


@end

