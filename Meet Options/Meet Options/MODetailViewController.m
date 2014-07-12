//
//  MODetailViewController.m
//  Meet Options temp
//
//  Created by The Wynn's  on 7/11/14.
//  Copyright (c) 2014 Optionvesting, LLC. All rights reserved.
//

#import "MODetailViewController.h"

@interface MODetailViewController ()
//- (void)configureView;
@end

@implementation MODetailViewController
/* Going to add this to subclass detailviewcontrollers
#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}
*/
 
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //[self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
