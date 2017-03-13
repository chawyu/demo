//
//  MessageMng.m
//  iOSDemo
//
//  Created by 周维 on 17/3/1.
//  Copyright © 2017年 chaw. All rights reserved.
//

#import "MessageMng.h"
#import "MessageEntity.h"
#import "MessageTextCell.h"

@implementation MessageMng
{
	@property(nonatomic, strong) MessageTextCell* textCell; //for height
	
}
-(id)init{
    self = [super init];
    if (self) {
        self.messageArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(CGFloat)cellHeightForMessage:(MessageEntity*)message{
	if(message.msgType == MessageType_Text){
		if(!self.textCell){
			self.textCell = [[MessageTextCell alloc] init];

		}
		return [self.textCell cellHeightForMessage:message];
	}else if(message.msgType == MessageType_Image){

	}else if(message.msgType == MessageType_Voice){

	}
	return 0;

}

-(void)addMessage:(MessageEntity*)message{
    [self.messageArray addObject:message];
    
}


@end
