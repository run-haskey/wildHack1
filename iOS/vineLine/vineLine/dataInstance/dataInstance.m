
#import "dataInstance.h"

@implementation AccountData
@synthesize hashKey = _hashKey;
@synthesize userID = _userID;
@synthesize userName = _userName;

-(id) init
{
    self.hashKey = @"";
    self.userID = @"";
    self.userName = @"";
    return [super init];
}

-(void) dealloc
{
    self.hashKey = nil;
    self.userID = nil;
    self.userName = nil;
    
    [super dealloc];
}
@end


@implementation  DataInstance
@synthesize account = _account;

-(id) init
{
    self.account = [[[AccountData alloc] init] autorelease];
 
    return [super init];
}

-(void) terminate
{
}

/**
 */
static DataInstance*  _instance = nil;
+ (DataInstance*)sharedManager
{
    // インスタンスを作成する
    if (!_instance) {
        _instance = [[DataInstance alloc] init];
    }
    
    return _instance;
}

@end