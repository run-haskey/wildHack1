@interface NSObject (performblock)
- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
@end

@implementation NSObject (performblock)
- (void)executeBlock__:(void (^)(void))block
{
    block();
    [block release];
}

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay
{
    [self performSelector:@selector(executeBlock__:)
               withObject:[block copy]
               afterDelay:delay];
}
@end