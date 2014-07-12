//
//  MOGlossaryDetailViewController.m
//  Meet Options
//
//  Created by The Wynn's  on 7/11/14.
//  Copyright (c) 2014 Optionvesting, LLC. All rights reserved.
//

#import "MOGlossaryDetailViewController.h"

@interface MOGlossaryDetailViewController ()

@end

@implementation MOGlossaryDetailViewController

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
    [self configureView];

    // This opens the url in the webview *** need to change to local file though...probably need to pass file path from masterview
//    NSString *fullURL = @"http://conecode.com";
//    NSURL *url = [NSURL URLWithString:fullURL];
//    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
//    [self.glossaryDefinitionWebView loadRequest:requestObj];

    // This is broken code to open local html
//    NSString *fullURL = self.detailItem;
//    NSURL *url = [NSURL fileURLWithPath:fullURL];
//    NSURLRequest *requestedObj = [NSURLRequest requestWithURL:url];
//    [self.glossaryDefinitionWebView loadRequest:requestedObj];
    
    
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:[[NSBundle mainBundle] URLForResource:self.detailItem withExtension:@"html"]];
    [self.glossaryDefinitionWebView loadRequest:requestObj];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
