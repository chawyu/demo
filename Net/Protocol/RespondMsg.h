

#import <Foundation/Foundation.h>
#import "RespondProtocol.h"
typedef void(^RequestCompletion)(id response,NSError* error);

/*
static uint32_t strLen(NSString *aString)
{
    return (uint32_t)[[aString dataUsingEncoding:NSUTF8StringEncoding] length];
}
 */


/**
 *  这是一个超级类，不能被直接使用
 */

#define TimeOutTimeInterval 10
//-----------------------
#define ChannelType_ShortConn 1
#define ChannelType_LongConn 2
#define ChannelType_All 3
@interface RespondMsg : NSObject<RespondProtocol>
@property (nonatomic,copy)RequestCompletion completion;
@property (nonatomic,strong)NSArray* args;

- (void)requestWithObject:(NSArray*)args Completion:(RequestCompletion)completion;
//----
- (id)UnserializeData:(NSData*)msgData;
- (NSData*)SerializeData;
- (int)requestCmdId;
- (int)requestChannel;
//----
- (BOOL)requestSendOnly;
- (BOOL)requestNeedAuthed;
- (BOOL)requestLimitFlow;
- (BOOL)requestLimitFrequency;
- (BOOL)requestNetworkSensitive;
//- (int)requestChannelStrategy;
//- (int)requestPriority;
- (int)requestRetryCount;
- (int)requestServerCost;
- (int)requestTotalCost;
//----
@end
