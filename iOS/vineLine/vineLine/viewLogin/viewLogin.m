/**
*/
#import "viewLogin.h"

#import "AFNetworking.h"
#import "UserDefaults.h"
#import "dataInstance.h"

@implementation viewLogin

@synthesize textfieldMail = _textfieldMail;
@synthesize textfieldPass = _textfieldPass;
@synthesize buttonLogin = _buttonLogin;
@synthesize labelDesc = _labelDesc;
@synthesize view = _view;

/**
 */
-(void) terminate
{
    self.buttonLogin = nil;
    self.textfieldPass = nil;
    self.buttonLogin = nil;
    self.labelDesc = nil;
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
    
    self.labelDesc = [[[UILabel alloc] init] autorelease];
    self.labelDesc.text = @"go Vine GO";
    self.labelDesc.font = [UIFont boldSystemFontOfSize:20.f];
    self.labelDesc.textColor = [UIColor whiteColor];
    [self.labelDesc sizeToFit];
    self.labelDesc.frame = CGRectMake((self.view.frame.size.width-self.labelDesc.frame.size.width)*0.5f, 40.f, self.labelDesc.frame.size.width, self.labelDesc.frame.size.height);
    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowColor:[UIColor colorWithRed:0.f green:0.f blue:0.f alpha:1.f]];
    [shadow setShadowBlurRadius:2.f];
    [shadow setShadowOffset:CGSizeMake(1.f, 1.f)];
    NSMutableAttributedString *attrStr = [[[NSMutableAttributedString alloc] initWithString:self.labelDesc.text] autorelease];
    [attrStr addAttribute:NSShadowAttributeName value:shadow range:NSMakeRange(0, [attrStr length])];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [attrStr length])];
    [self.labelDesc setAttributedText:attrStr];
    [shadow release];
    [self.view addSubview:self.labelDesc];
    
    CGSize sizeTextField = CGSizeMake(280.f, 40.f);
    self.textfieldMail = [[[UITextField alloc] init] autorelease];
    self.textfieldMail.frame = CGRectMake((self.view.frame.size.width-sizeTextField.width)*0.5f, self.labelDesc.frame.origin.y+self.labelDesc.frame.size.height+40.f, sizeTextField.width, sizeTextField.height);
    self.textfieldMail.borderStyle = UITextBorderStyleRoundedRect;
    self.textfieldMail.delegate = self;
    self.textfieldMail.text = @"";
    if( [[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultMailAddress] ) {
        self.textfieldMail.text = [[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultMailAddress];
    }
    self.textfieldMail.placeholder = @"your MailAddress";
    [self.textfieldMail setReturnKeyType:UIReturnKeyDone];
    self.textfieldMail.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.textfieldMail addTarget:self action:@selector(EndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:self.textfieldMail];
    
    self.textfieldPass = [[[UITextField alloc] init] autorelease];
    self.textfieldPass.frame = CGRectMake((self.view.frame.size.width-sizeTextField.width)*0.5f, self.textfieldMail.frame.origin.y+self.textfieldMail.frame.size.height+20.f, sizeTextField.width, sizeTextField.height);
    self.textfieldPass.borderStyle = UITextBorderStyleRoundedRect;
    self.textfieldPass.delegate = self;
    self.textfieldPass.secureTextEntry = YES;
    self.textfieldPass.text = @"";
    if( [[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultPassWord] ) {
        self.textfieldPass.text = [[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultPassWord];
    }
    self.textfieldPass.placeholder = @"Password";
    [self.textfieldPass setReturnKeyType:UIReturnKeyDone];
    self.textfieldPass.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.textfieldPass addTarget:self action:@selector(EndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:self.textfieldPass];
    
    CGSize sizeButton = CGSizeMake(80.f, 80.f);
    self.buttonLogin = [[[UIButton alloc] init] autorelease];
    self.buttonLogin.frame = CGRectMake((self.view.frame.size.width-sizeButton.width)*0.5f, self.view.frame.size.height-sizeButton.height-40.f, sizeButton.width, sizeButton.height);
    self.buttonLogin.backgroundColor = [UIColor clearColor];
    self.buttonLogin.titleLabel.font = [UIFont boldSystemFontOfSize:18.f];
    [self.buttonLogin setTitle:@"Login" forState:UIControlStateNormal];
    [self.buttonLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.buttonLogin setBackgroundColor:[UIColor colorWithRed:0.f green:0.92f blue:0.71f alpha:1.f]];
    self.buttonLogin.layer.cornerRadius = 40.f;
    self.buttonLogin.clipsToBounds = YES;
    
    self.buttonLogin.userInteractionEnabled = YES;
    UITapGestureRecognizer* tapGestureLogin = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLogin:)];
    tapGestureLogin.numberOfTapsRequired = 1;
	[self.buttonLogin addGestureRecognizer:tapGestureLogin];
	[tapGestureLogin release];
    [self.view addSubview:self.buttonLogin];
    
    return [super init];
}

/**
 */
-(void) apiLogin
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"https://api.vineapp.com/users/authenticate"
      parameters:@{@"username":self.textfieldMail.text,@"password":self.textfieldPass.text}
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             // OK
             NSLog(@"responseObject: %@", responseObject);
             if ([self.delegate respondsToSelector:@selector(didSuccessLogin)]) {
                 // ログイン成功したらアカウント情報をアプリ内に保持するå
                 [[NSUserDefaults standardUserDefaults] setObject:self.textfieldMail.text forKey:kUserDefaultMailAddress];
                 [[NSUserDefaults standardUserDefaults] setObject:self.textfieldPass.text forKey:kUserDefaultPassWord];
                 [[NSUserDefaults standardUserDefaults] synchronize];
                 
                 [DataInstance sharedManager].account.hashKey = [[responseObject objectForKey:@"data"] objectForKey:@"key"];
                 [DataInstance sharedManager].account.userID = [[responseObject objectForKey:@"data"] objectForKey:@"userId"];
                 [DataInstance sharedManager].account.userName = [[responseObject objectForKey:@"data"] objectForKey:@"username"];
                 
                 [self.delegate didSuccessLogin];
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             // NG
             NSLog(@"Error: %@", error);
         }];
}

/**
 */
- (void)tapLogin:(UITapGestureRecognizer*)sender
{
    BOOL isResult = false;
    if( self.textfieldMail.text && self.textfieldPass ) {
        if( ![self.textfieldMail.text isEqualToString:@""] && ![self.textfieldPass.text isEqualToString:@""] ) {
            isResult = true;
        }
    }
    
    if( isResult ) {
        if ([self.delegate respondsToSelector:@selector(didStartLogin)]) {
            [self.delegate didStartLogin];
        }
        
        [self.textfieldMail resignFirstResponder];
        [self.textfieldPass resignFirstResponder];
        
        [self apiLogin];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"エラー" message:@"入力情報が正しくありません"
                                  delegate:self cancelButtonTitle:@"確認" otherButtonTitles:nil];
        [alert show];
    }
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