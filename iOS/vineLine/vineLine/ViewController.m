//
//  ViewController.m
//  vineLine
//
//  Created by yuuki naniwa on 2014/02/08.
//  Copyright (c) 2014年 hackhack. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize viewLogin = _viewLogin;

/**
 */
-(void) terminate
{
    self.viewLogin = nil;
}

-(void) dealloc
{
    [self terminate];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.viewLogin = [[[viewLogin alloc] init] autorelease];
    [self.view addSubview:self.viewLogin.view];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
