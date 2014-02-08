//
//  ViewController.h
//  vineLine
//
//  Created by yuuki naniwa on 2014/02/08.
//  Copyright (c) 2014年 hackhack. All rights reserved.
//
#ifndef VIEW_CONTROLLER
#define VIEW_CONTROLLER

#import <UIKit/UIKit.h>
#import "viewLogin.h"
#import "viewTimeline.h"

@interface ViewController : UIViewController<LoginViewDelegate,TimeLineViewDelegate>
{
}
@property (nonatomic, retain) viewTimeline* viewTimeline;
@property (nonatomic, retain) viewLogin* viewLogin;

@property (nonatomic, retain) UIActivityIndicatorView* indicator;

-(void) dealloc;
@end
#endif
