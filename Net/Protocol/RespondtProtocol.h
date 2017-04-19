//
//  DDNetworkAPIProtocol.h
//  Duoduo
//
//  Created by 独嘉 on 14-4-24.
//  Copyright (c) 2015年 MoguIM All rights reserved.
//

#import <Foundation/Foundation.h>
typedef id(^Unpack)(NSData* data);
typedef NSMutableData*(^Pack)(id object);

@protocol RespondProtocol <NSObject>
@required

/**
 *  请求超时时间
 *
 *  @return 超时时间
 */
- (int)requestTimeOut;

/**
 *  请求的serviceID
 *
 *  @return 对应的serviceID
 */
- (int)requestMsgId;

/**
 *  解析数据的block
 *
 *  @return 解析数据的block
 */
- (Unpack)Unserialize;

/**
 *  打包数据的block
 *
 *  @return 打包数据的block
 */
- (Pack)Serialize;
@end
