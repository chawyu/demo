
#import <Foundation/Foundation.h>
typedef id(^Unpack)(NSData* data);
typedef NSMutableData*(^Pack)(id object);

@protocol RespondProtocol <NSObject>
@required
//  解析数据的block
- (id)UnserializeData:(NSData*)msgData;
// 打包数据的block'
- (NSData*)SerializeData;
- (int)requestCmdId;
- (int)requestChannel;
@optional
- (BOOL)requestSendOnly;
- (BOOL)requestNeedAuthed;
- (BOOL)requestLimitFlow;
- (BOOL)requestLimitFrequency;
- (BOOL)requestNetworkSensitive;
- (int)requestChannelStrategy;
- (int)requestPriority;
- (int)requestRetryCount;
- (int)requestServerCost;
- (int)requestTotalCost;



/**
 *  请求的serviceID
 *
 *  @return 对应的serviceID
 */
//- (int)requestServiceID;

/**
 *  请求返回的serviceID
 *
 *  @return 对应的serviceID
 */
//- (int)responseServiceID;



@end
