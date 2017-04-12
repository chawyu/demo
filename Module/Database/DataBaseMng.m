
#import "DataBaseMng.h"


@implementation DataBaseMng
{
    FMDatabase* _database;
    FMDatabaseQueue* _dataBaseQueue;
}
+ (instancetype)shareInstance
{
    static DataBaseMng* g_databaseMng;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_databaseMng = [[DataBaseMng alloc] init];
        [NSString stringWithFormat:@""];
    });
    return g_databaseMng;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        //初始化数据库
        [self opendb];
    }
    return self;
}

- (void)opendb
{
}
@end