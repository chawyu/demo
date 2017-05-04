//
//  MsgTest.m
//  iOSDemo
//
//  Created by 周维 on 17/4/26.
//  Copyright © 2017年 chaw. All rights reserved.
//

#import "MsgTest.h"
#import "Main.pb.h"

@implementation MsgTest
- (id)UnserializeData:(NSData*)msgData{
    HelloResponse *imNormalRsp = [HelloResponse parseFromData:msgData];
    return imNormalRsp;
}
- (NSData*)SerializeData{

    HelloRequest* person = [[[[HelloRequest builder] setUser:@"chaw"]
                        setText:@"helllo chaw"]
                        build];
    

    return [person data];
}
- (int)requestCmdId{
    return 100;
}


@end
