//
//  MOAppDelegate.m
//  Meet Options
//
//  Created by The Wynn's  on 7/11/14.
//  Copyright (c) 2014 Optionvesting, LLC. All rights reserved.
//
#import "MOAppDelegate.h"

@implementation MOAppDelegate

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window.tintColor = UIColorFromRGB(0xF2B019);
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 1);
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           UIColorFromRGB(0xF2B019),
                                                           NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"NeutraDisp-Titling" size:18.0], NSFontAttributeName, nil]];
    
    
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                       [UIColor whiteColor], UITextAttributeTextColor,
//                                                       nil] forState:UIControlStateNormal];
////    UIColor *titleHighlightedColor = [UIColor colorWithRed:153/255.0 green:192/255.0 blue:48/255.0 alpha:1.0];
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                       [UIColor blueColor], UITextAttributeTextColor,
//                                                       nil] forState:UIControlStateHighlighted];
//    

    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbar.png"] forBarMetrics:UIBarMetricsDefault];
    
//    UIImage* tabBarBackground = [UIImage imageNamed:@"tabbar.png"];
    
    
    
    
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbar.png"]];
    [[UITabBar appearance] setTintColor:UIColorFromRGB(0x000000)];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"NeutraDisp-Bold" size:17.0f]}                                                forState:UIControlStateNormal];
//
//    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"NeutraDisp-Bold" size:17.0f],
//                                                        NSForegroundColorAttributeName : UIColorFromRGB(0x000000)
//                                                        } forState:UIControlStateHighlighted];
    
    
    
    
//    [[UITabBar appearance] setSelectedImageTintColor:[UIColor greenColor]];
//7B440F

    //    NSDictionary *navbarbuttonTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
//                                                [UIColor blackColor],NSForegroundColorAttributeName,
//                                                [UIFont fontWithName:@"NeutraDisp-Medium" size:21.0], NSFontAttributeName,
//                                                [UIColor clearColor], NSShadowAttributeName,
//                                                nil];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           UIColorFromRGB(0xFFFFFFF),
                                                           NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"NeutraDisp-Titling" size:15.0], NSFontAttributeName, nil]forState:UIControlStateNormal];

    [[UINavigationBar appearance] setTintColor:UIColorFromRGB(0xF2B019)];
    
     
    // Override point for customization after application launch.
    return YES;

}



							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
