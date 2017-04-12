#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface MTTDatabaseUtil : NSObject
+ (instancetype)shareInstance;
- (void)opendb;
@end