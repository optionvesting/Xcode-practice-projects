//
//  MOGlossaryDetailViewController.m
//  Meet Options
//
//  Created by The Wynn's  on 7/11/14.
//  Copyright (c) 2014 Optionvesting, LLC. All rights reserved.
//

#import "MOGlossaryDetailViewController.h"
#define DEFAULTWEBVIEWFONTSIZE 15
#pragma mark - private interface

@interface MOGlossaryDetailViewController ()

@property (nonatomic,assign)NSInteger stepperScale;

@end

@implementation MOGlossaryDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.stepperScale = DEFAULTWEBVIEWFONTSIZE;
    self.myStepper.minimumValue = 5.0;
    self.myStepper.value = 15.0;
    self.myStepper.maximumValue = 24.0;
    self.myStepper.stepValue = 5.0;
    [[UIStepper appearance] setTintColor:[UIColor redColor]];


    // This opens the url in the webview *** need to change to local file though...probably need to pass file path from masterview
//    NSString *fullURL = @"http://conecode.com";
//    NSURL *url = [NSURL URLWithString:fullURL];
//    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
//    [self.glossaryDefinitionWebView loadRequest:requestObj];

    

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];    
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:[[NSBundle mainBundle] URLForResource:self.detailItem withExtension:@"html"]];
    [self.glossaryDefinitionWebView loadRequest:requestObj];
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
    [self.glossaryDefinitionWebView stringByEvaluatingJavaScriptFromString:jsForTextSize];
}

@end
