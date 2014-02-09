/**
 */

@interface AccountData : NSObject
{
}
@property (nonatomic, retain) NSString* hashKey;
@property (nonatomic, retain) NSString* userID;
@property (nonatomic, retain) NSString* userName;

-(id) init;
-(void) dealloc;

@end

@interface DataInstance : NSObject
{
}
@property (nonatomic, retain) AccountData* account;

-(id) init;

-(void) terminate;

+(DataInstance*)sharedManager;

@end