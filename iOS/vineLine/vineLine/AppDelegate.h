//
//  AppDelegate.h
//  vineLine
//
//  Created by yuuki naniwa on 2014/02/08.
//  Copyright (c) 2014年 hackhack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) ViewController* viewController;
@property (nonatomic, retain) UINavigationController *navigationController;

@end
