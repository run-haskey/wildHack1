//
//  AppDelegate.m
//  vineLine
//
//  Created by yuuki naniwa on 2014/02/08.
//  Copyright (c) 2014年 hackhack. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize viewController = viewController_;
@synthesize navigationController = navigationController_;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:0 diskCapacity:0 diskPath:nil];
    [NSURLCache setSharedURLCache:sharedCache];
    [sharedCache release];
    
    CGRect rc = [UIScreen mainScreen].applicationFrame;
    CGRect rcMainView = CGRectMake(rc.origin.x, 0.f, rc.size.width, rc.size.height);
    
    self.window = [[[UIWindow alloc] initWithFrame:rcMainView] autorelease];
    self.window.backgroundColor = [UIColor blackColor];
    
    self.viewController = [[[ViewController alloc] init] autorelease];
    self.navigationController = [[[UINavigationController alloc] initWithRootViewController:self.viewController] autorelease];
    self.navigationController.navigationBarHidden = YES;
    
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    
    
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
