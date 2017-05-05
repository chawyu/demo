

#import <Foundation/Foundation.h>
//typedef id(^Unpack)(NSData* data);

@protocol NoRespondProtocol <NSObject>
@required
/**
 *  数据包中的serviceID
 *
 *  @return serviceID
 */
- (int)responseServiceID;

/**
 *  数据包中的commandID
 *
 *  @return commandID
 */
- (int)responseCommandID;

/**
 *  解析数据包
 *
 *  @return 解析数据包的block
 */
- (int)UnserializeData:(NSData*) msgData;
@end
