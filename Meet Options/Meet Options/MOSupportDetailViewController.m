//
//  MOSupportDetailViewController.m
//  Meet Options
//
//  Created by The Wynn's  on 7/11/14.
//  Copyright (c) 2014 Optionvesting, LLC. All rights reserved.
//

#import "MOSupportDetailViewController.h"

@interface MOSupportDetailViewController ()

@end

@implementation MOSupportDetailViewController

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
    // This works!
//        NSString *fullURL = @"https://drive.google.com/uc?id=0B4ciiqCPy_XzdkRoOXBCSUVBWVk";
        NSURL *url = [NSURL URLWithString:self.detailItem];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [self.supportWebView loadRequest:requestObj];
    
    
}



//-(void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    NSURLRequest *requestObj = [NSURLRequest requestWithURL:[[NSBundle mainBundle] URLForResource:@"The Stock Exchange" withExtension:@"html"]];
//    [self.supportWebView loadRequest:requestObj];
//}


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
