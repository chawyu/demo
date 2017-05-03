

#import "RespondMsg.h"
#import "NetworkService.h"

//#import "DDSeqNoManager.h"

static uint16_t theSeqNo = 0;

@implementation RespondMsg
- (void)requestWithObject:(id)object Completion:(RequestCompletion)completion
{
    [[NetworkService sharedInstance] startTask:self];
    //保存完成块
    self.completion = completion;
    /*
    //seqNo
    theSeqNo ++;
    _seqNo = theSeqNo;
    //注册接口
    BOOL registerAPI = [[DDAPISchedule instance] registerApi:(id<DDAPIScheduleProtocol>)self];
    
    if (!registerAPI)
    {
        return;
    }
    
    //注册请求超时
    if ([(id<DDAPIScheduleProtocol>)self requestTimeOutTimeInterval] > 0)
    {
        [[DDAPISchedule instance] registerTimeoutApi:(id<DDAPIScheduleProtocol>)self];
    }
    
    //保存完成块
    self.completion = completion;
    
    
    //数据打包
    Package package = [(id<DDAPIScheduleProtocol>)self packageRequestObject];
    NSMutableData* requestData = package(object,_seqNo);
    
    //发送
    if (requestData)
    {
        [[DDAPISchedule instance] sendData:requestData];
        //        [[DDTcpClientManager instance] writeToSocket:requestData];
    }
     */
}
//---required
- (id)UnserializeData:(NSData*)msgData{return -1;}
- (NSData*)SerializeData{return NULL;}
- (int)requestCmdId{return 0;}
- (int)requestChannel{return ChannelType_LongConn;}
//---option
- (BOOL)requestSendOnly{return false;}
- (BOOL)requestNeedAuthed{return true;}
- (BOOL)requestLimitFlow{return true;}
- (BOOL)requestLimitFrequency{return true;}
- (BOOL)requestNetworkSensitive{return true;}
//- (int)requestChannelStrategy{}
//- (int)requestPriority{}
- (int)requestRetryCount{return -1;}
- (int)requestServerCost{return 0;}
- (int)requestTotalCost{return 0;}
@end
