//
//  MOGlossaryDetailViewController.m
//  Meet Options
//
//  Created by The Wynn's  on 7/11/14.
//  Copyright (c) 2014 Optionvesting, LLC. All rights reserved.
//

#import "MOGlossaryDetailViewController.h"
#define DEFAULTWEBVIEWFONTSIZE 15
#define SAMPLE_HTML @"sample"
#pragma mark - private interface

@interface MOGlossaryDetailViewController ()

@property (nonatomic,assign)NSInteger stepperScale;


@end

@implementation MOGlossaryDetailViewController

// *******************


// *******************

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.stepperScale = DEFAULTWEBVIEWFONTSIZE;
    self.myStepper.minimumValue = 5.0;
    self.myStepper.value = 15.0;
    self.myStepper.maximumValue = 24.0;
    self.myStepper.stepValue = 5.0;

    // This opens the url in the webview *** need to change to local file though...probably need to pass file path from masterview
//    NSString *fullURL = @"http://conecode.com";
//    NSURL *url = [NSURL URLWithString:fullURL];
//    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
//    [self.glossaryDefinitionWebView loadRequest:requestObj];

    

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self loadWebViewContent];
    
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:[[NSBundle mainBundle] URLForResource:self.detailItem withExtension:@"html"]];
    [self.glossaryDefinitionWebView loadRequest:requestObj];
}

//#pragma mark - Loading Views
//-(void)loadWebViewContent
//{
//    NSString* fileName = [NSBundle pathForResource:SAMPLE_HTML ofType:@"html" inDirectory:[NSBundle mainBundle].bundlePath];
//    NSError* error;
//    NSStringEncoding usedEncoding = NSUTF8StringEncoding;
//    NSString* webViewContent = [NSString stringWithContentsOfFile:fileName usedEncoding:&usedEncoding error:&error];
//    NSString *resourcePath = [[[[NSBundle mainBundle] resourcePath]
//                               stringByReplacingOccurrencesOfString:@"/" withString:@"//"]
//                              stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
//    [self.glossaryDefinitionWebView loadHTMLString:webViewContent baseURL:[NSURL URLWithString:  [NSString stringWithFormat:@"file:/%@//", resourcePath]]];
//    self.glossaryDefinitionWebView.delegate = self;
//    
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
    
    // First reset the height of webview frame. Otherwise the sizeThatFits will return the current size
    // if it can fit the new text - works while scaling up but not useful when scaling down.
    CGRect adjustedFrame = self.glossaryDefinitionWebView.frame;
    adjustedFrame.size.height = 1;
    self.glossaryDefinitionWebView.frame = adjustedFrame;
    
    CGSize frameSize = [self.glossaryDefinitionWebView sizeThatFits:CGSizeZero];
    adjustedFrame.size.height = frameSize.height ;
    self.glossaryDefinitionWebView.frame = adjustedFrame;
    
    /// Adjust scroll view content size (Make sure your factor in the y-offset at which the webview begins)
    CGSize scrollViewSize = self.myScrollView.contentSize;
    scrollViewSize.height = adjustedFrame.size.height + self.glossaryDefinitionWebView.frame.origin.y ;
    self.myScrollView.contentSize = scrollViewSize;
    
    
}

@end
