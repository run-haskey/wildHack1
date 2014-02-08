//
//  ViewController.m
//  vineLine
//
//  Created by yuuki naniwa on 2014/02/08.
//  Copyright (c) 2014年 hackhack. All rights reserved.
//

#import "ViewController.h"
#import "performblock.h"

@implementation ViewController

@synthesize viewLogin = _viewLogin;
@synthesize viewTimeline = _viewTimeline;
@synthesize indicator = _indicator;

/**
 */
-(void) terminate
{
    self.viewLogin = nil;
    self.indicator = nil;
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
    self.viewLogin.delegate = self;
    [self.view addSubview:self.viewLogin.view];

    self.viewTimeline = [[[viewTimeline alloc] init] autorelease];
    self.viewTimeline.delegate = self;
    [self.viewTimeline.view setHidden:YES];
    [self.view addSubview:self.viewTimeline.view];
    
    self.indicator = [[[UIActivityIndicatorView alloc] init] autorelease];
    self.indicator.frame = CGRectMake(0.f, 0.f, self.view.frame.size.width, self.view.frame.size.height);
    self.indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    self.indicator.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5f];
    [self.view addSubview:self.indicator];
    [self.indicator setHidden:YES];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 */
-(void) didTapLogin
{
    NSLog(@"didTapLogin..");
    
    //(仮) とりあえずだす
    [self.indicator setHidden:NO];
    [self.indicator startAnimating];
    [self.view bringSubviewToFront:self.indicator];
    
    //(仮) 通信した事にして(画面上)完了したら次の画面へ行く
    [self performBlock:^{
        [self.indicator stopAnimating];
        [self.indicator setHidden:YES];
        
        [self.view bringSubviewToFront:self.viewTimeline.view];
        
        self.viewTimeline.view.alpha = 0.f;
        self.viewLogin.view.alpha = 1.f;
        
        [self.viewLogin.view setHidden:NO];
        [self.viewTimeline.view setHidden:NO];
        
        [UIView animateWithDuration:0.5f
                         animations:^{
                             self.viewLogin.view.alpha = 0.f;
                             self.viewTimeline.view.alpha = 1.f;
                         }
                         completion:^(BOOL finished){
                             [self.viewLogin.view setHidden:YES];
                         }];
        
    } afterDelay:2.5f];
}

/**
 */
-(void) didSelectReturn
{
    self.viewTimeline.view.alpha = 1.f;
    self.viewLogin.view.alpha = 0.f;
    
    [self.view bringSubviewToFront:self.viewLogin.view];

    [self.viewLogin.view setHidden:NO];
    [self.viewTimeline.view setHidden:NO];
    
    [UIView animateWithDuration:0.5f
                     animations:^{
                         self.viewLogin.view.alpha = 1.f;
                         self.viewTimeline.view.alpha = 0.f;
                     }
                     completion:^(BOOL finished){
                         [self.viewTimeline.view setHidden:YES];
                     }];
}

@end
