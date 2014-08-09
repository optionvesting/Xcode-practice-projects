//
//  MOSupportDetailViewController.m
//  Meet Options
//
//  Created by The Wynn's  on 7/11/14.
//  Copyright (c) 2014 Optionvesting, LLC. All rights reserved.
//
#import "MOSupportDetailViewController.h"
#define DEFAULTWEBVIEWFONTSIZE 15
#pragma mark - private interface

@interface MOSupportDetailViewController ()
//- (void)configureView;

@property (nonatomic,assign)NSInteger stepperScale;

@end

@implementation MOSupportDetailViewController

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.detail;
    self.stepperScale = DEFAULTWEBVIEWFONTSIZE;
    self.myStepper.minimumValue = 5.0;
    self.myStepper.value = 15.0;
    self.myStepper.maximumValue = 24.0;
    self.myStepper.stepValue = 5.0;
    //    [[UIStepper appearance] setTintColor:[UIColor redColor]];
    
    
    // This opens the url in the webview *** need to change to local file though...probably need to pass file path from masterview
    //    NSString *fullURL = @"http://conecode.com";
    //    NSURL *url = [NSURL URLWithString:fullURL];
    //    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    //    [self.tutorialsDefinitionWebView loadRequest:requestObj];
    
    
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    //    [super viewDidAppear:animated];
    
    
    if ([self.link rangeOfString:@"http"].location == NSNotFound) {
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:[[NSBundle mainBundle] URLForResource:self.link withExtension:@"html"]];
        [self.supportWebView loadRequest:requestObj];
        
    } else {
        NSURL *url = [NSURL URLWithString:self.link];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [self.supportWebView loadRequest:requestObj];
        
    }
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebviewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (!webView.isLoading)
    {
        [self scaleWebview];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Server Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

#pragma mark - UIEvent handlers
- (IBAction)onStepperTapped:(id)sender {
    self.stepperScale = self.myStepper.value;
    [self performSelector:@selector(scaleWebview) onThread:[NSThread mainThread] withObject:nil waitUntilDone:NO];
}

#pragma mark - helpers
-(void)scaleWebview
{
    // Adjust the text size (specified as a percent. 100 is default normal)
    NSString *jsForTextSize = [[NSString alloc] initWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%d%%'", self.stepperScale*100/DEFAULTWEBVIEWFONTSIZE];
    [self.supportWebView stringByEvaluatingJavaScriptFromString:jsForTextSize];
}

@end