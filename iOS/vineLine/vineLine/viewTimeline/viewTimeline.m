/**
 */
#import "viewTimeline.h"
#import "AFNetworking.h"
#import "dataInstance.h"

@implementation viewTimeline

@synthesize view = _view;
@synthesize scrollview = _scrollview;
@synthesize viewSearch = _viewSearch;
@synthesize buttonReturn = _buttonReturn;

/**
 */
-(void) terminate
{
    self.view = nil;
}

/**
 */
-(void) dealloc
{
    [self terminate];
    [super dealloc];
}

/**
 */
-(id) init
{
    CGRect rc = [UIScreen mainScreen].applicationFrame;
    self.view = [[[UIView alloc] init] autorelease];
    self.view.frame = CGRectMake(0.f, 20.f, rc.size.width, rc.size.height);
    self.view.backgroundColor = [UIColor colorWithRed:0.4f green:0.4f blue:0.4f alpha:1.f];
    
    self.viewSearch = [[[viewSearch alloc] init] autorelease];
    [self.view addSubview:self.viewSearch.view];
    
    self.scrollview = [[[UIScrollView alloc] init] autorelease];
    self.scrollview.frame = CGRectMake(0.f,self.viewSearch.view.frame.size.height,self.view.frame.size.width,self.view.frame.size.height-self.viewSearch.view.frame.size.height);
    self.scrollview.backgroundColor = [UIColor blackColor];
    [self.scrollview setScrollEnabled:NO];
    self.scrollview.userInteractionEnabled = YES;
    self.scrollview.delegate = self;
    [self.view addSubview:self.scrollview];
    
    CGSize sizeButton = CGSizeMake(48.f, 48.f);
    self.buttonReturn = [[[UIButton alloc] init] autorelease];
    self.buttonReturn.frame = CGRectMake(20.f, self.view.frame.size.height-sizeButton.height-20.f, sizeButton.width, sizeButton.height);
    self.buttonReturn.backgroundColor = [UIColor clearColor];
    self.buttonReturn.titleLabel.font = [UIFont boldSystemFontOfSize:12.f];
    [self.buttonReturn setTitle:@"戻る" forState:UIControlStateNormal];
    [self.buttonReturn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.buttonReturn setBackgroundColor:[UIColor colorWithRed:0.f green:0.92f blue:0.71f alpha:1.f]];
    self.buttonReturn.layer.cornerRadius = 24.f;
    self.buttonReturn.clipsToBounds = YES;
    
    self.buttonReturn.userInteractionEnabled = YES;
    UITapGestureRecognizer* tapGestureLogin = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapReturn:)];
    tapGestureLogin.numberOfTapsRequired = 1;
	[self.buttonReturn addGestureRecognizer:tapGestureLogin];
	[tapGestureLogin release];
    [self.view addSubview:self.buttonReturn];
    
    return [super init];
}

/**
 */
- (void)tapReturn:(UITapGestureRecognizer*)sender
{
    if ([self.delegate respondsToSelector:@selector(didSelectReturn)]) {
        [self.delegate didSelectReturn];
    }
}

/**
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
}

/**
 */
-(void) apiGetTimeline
{
    AccountData* account = [DataInstance sharedManager].account;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"https://api.vineapp.com/timelines/global"
       parameters:@{@"vine-session-id":account.hashKey}
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              // OK
              NSLog(@"responseObject: %@", responseObject);
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              // NG
              NSLog(@"Error: %@", error);
              UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"エラー" message:[error localizedDescription]
                                                             delegate:self cancelButtonTitle:@"確認" otherButtonTitles:nil];
              [alert show];
          }];
}

@end