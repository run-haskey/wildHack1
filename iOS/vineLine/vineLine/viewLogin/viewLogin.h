/**
*/
#ifndef VIEW_LOGIN
#define VIEW_LOGIN
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol LoginViewDelegate <NSObject>

-(void) didStartLogin;
-(void) didSuccessLogin;

@end

@interface viewLogin : NSObject<UITextFieldDelegate>
{
}

@property (nonatomic, retain) UIView*       view;
@property (nonatomic, retain) UILabel*      labelDesc;
@property (nonatomic, retain) UITextField* textfieldMail;
@property (nonatomic, retain) UITextField* textfieldPass;
@property (nonatomic, retain) UIButton* buttonLogin;

@property (nonatomic, assign) id<LoginViewDelegate> delegate;

-(id) init;
-(void) dealloc;
@end
#endif