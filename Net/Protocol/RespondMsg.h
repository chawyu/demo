

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
@interface RespondMsg : NSObject
@property (nonatomic,copy)RequestCompletion completion;
//@property (nonatomic,readonly)uint16_t seqNo;

- (void)requestWithObject:(id)object Completion:(RequestCompletion)completion;

@end
