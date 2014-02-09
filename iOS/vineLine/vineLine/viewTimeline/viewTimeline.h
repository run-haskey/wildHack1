/**
 */
#ifndef VIEW_TIMELINE
#define VIEW_TIMELINE

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "viewSearch.h"

@protocol TimeLineViewDelegate <NSObject>

-(void) didSelectReturn;

@end

@interface viewTimeline : NSObject<UIScrollViewDelegate>
{
}

@property (nonatomic, retain) UIView*       view;
@property (nonatomic, retain) UIScrollView* scrollview;
@property (nonatomic, retain) viewSearch* viewSearch;
@property (nonatomic, retain) UIButton* buttonReturn;

@property (nonatomic, assign) id<TimeLineViewDelegate> delegate;

-(id) init;
-(void) dealloc;

-(void) apiGetTimeline;

@end

#endif