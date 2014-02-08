/**
 */
#import "viewSearch.h"


@implementation viewSearch

@synthesize view = _view;
@synthesize buttonSearch = _buttonSearch;
@synthesize textfieldSearch = textfieldSearch_;

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
    self.view.frame = CGRectMake(0.f, 0.f, rc.size.width, 60.f);
    self.view.backgroundColor = [UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.f];
    
    self.textfieldSearch = [[[UITextField alloc] init] autorelease];
    self.textfieldSearch.frame = CGRectMake(10.f,10.f,230.f,40.f);
    self.textfieldSearch.borderStyle = UITextBorderStyleRoundedRect;
    self.textfieldSearch.delegate = self;
    self.textfieldSearch.text = @"";
    self.textfieldSearch.placeholder = @"検索ワード";
    [self.textfieldSearch setReturnKeyType:UIReturnKeyDone];
    self.textfieldSearch.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.textfieldSearch addTarget:self action:@selector(EndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:self.textfieldSearch];
    
    self.buttonSearch = [[[UIButton alloc] init] autorelease];
    self.buttonSearch.frame = CGRectMake(self.textfieldSearch.frame.origin.x+self.textfieldSearch.frame.size.width+10.f,10.f,60.f,40.f);
    self.buttonSearch.backgroundColor = [UIColor clearColor];
    self.buttonSearch.titleLabel.font = [UIFont boldSystemFontOfSize:15.f];
    [self.buttonSearch setTitle:@"検索" forState:UIControlStateNormal];
    [self.buttonSearch setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.buttonSearch setBackgroundColor:[UIColor colorWithRed:0.f green:0.92f blue:0.71f alpha:1.f]];
    self.buttonSearch.layer.cornerRadius = 5.f;
    self.buttonSearch.clipsToBounds = YES;
    
    self.buttonSearch.userInteractionEnabled = YES;
    UITapGestureRecognizer* tapGestureLogin = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSearch:)];
    tapGestureLogin.numberOfTapsRequired = 1;
	[self.buttonSearch addGestureRecognizer:tapGestureLogin];
	[tapGestureLogin release];
    [self.view addSubview:self.buttonSearch];
    
    return [super init];
}

/**
 */
- (void)tapSearch:(UITapGestureRecognizer*)sender
{
}

/**
 */
-(void)EndOnExit:(UITextField*)textfield
{
    // ここに何かの処理を記述する
    // （引数の textfield には呼び出し元のUITextFieldオブジェクトが引き渡されてきます）
    [textfield resignFirstResponder];
}

@end