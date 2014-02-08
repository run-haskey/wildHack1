/**
*/
#import "viewLogin.h"

#import "UserDefaults.h"

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
    self.view.frame = CGRectMake(0.f, 0.f, rc.size.width, rc.size.height);
    self.view.backgroundColor = [UIColor colorWithRed:0.4f green:0.4f blue:0.4f alpha:1.f];
    
    self.labelDesc = [[[UILabel alloc] init] autorelease];
    self.labelDesc.text = @"さあ、ログインだ。";
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
    self.textfieldMail.placeholder = @"メールアドレス 半角へ英数小文字";
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
    self.textfieldPass.placeholder = @"パスワード 半角へ英数小文字";
    [self.textfieldPass setReturnKeyType:UIReturnKeyDone];
    self.textfieldPass.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.textfieldPass addTarget:self action:@selector(EndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:self.textfieldPass];
    
    CGSize sizeButton = CGSizeMake(80.f, 80.f);
    self.buttonLogin = [[[UIButton alloc] init] autorelease];
    self.buttonLogin.frame = CGRectMake((self.view.frame.size.width-sizeButton.width)*0.5f, self.textfieldPass.frame.origin.y+self.textfieldPass.frame.size.height+30.f, sizeButton.width, sizeButton.height);
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
- (void)tapLogin:(UITapGestureRecognizer*)sender
{
    if ([self.delegate respondsToSelector:@selector(didTapLogin)]) {
        [[NSUserDefaults standardUserDefaults] setObject:self.textfieldMail.text forKey:kUserDefaultMailAddress];
        [[NSUserDefaults standardUserDefaults] setObject:self.textfieldPass.text forKey:kUserDefaultPassWord];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self.delegate didTapLogin];
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