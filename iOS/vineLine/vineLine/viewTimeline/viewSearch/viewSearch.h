/**
 */
#ifndef VIEW_SEARCH
#define VIEW SEARCH

@interface viewSearch : NSObject<UITextFieldDelegate>
{
}

@property (nonatomic, retain) UIView*       view;
@property (nonatomic, retain) UIButton*     buttonSearch;
@property (nonatomic, retain) UITextField* textfieldSearch;

-(id) init;
-(void) dealloc;

@end

#endif