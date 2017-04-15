//
//  NotifyCell.m
//  iOSDemo
//
//  Created by 周维 on 17/2/16.
//  Copyright © 2017年 chaw. All rights reserved.
//

#import "NotifyCell.h"
#import "UserEntity.h"
#import "RecentEntity.h"
#import "UserMng.h"
@interface NotifyCell ()
@property (strong, nonatomic) UIImageView* icon;
@property (strong, nonatomic) UILabel* name, *context, *time;
@property (copy, nonatomic) NSString* myname;
@end

@implementation NotifyCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if (!self.icon) {
            self.icon = [[UIImageView alloc ] initWithFrame:CGRectMake(10, ([NotifyCell cellHeight]-48)/2, 48, 48) ];
            [self.contentView addSubview:self.icon];
        }
        if (!self.name) {
            self.name = [[UILabel alloc] initWithFrame:CGRectMake(75, 8, 200, 25)];
            self.name.font = [UIFont systemFontOfSize:17];
            [self.contentView addSubview:self.name];
            
        }
        if (!self.context) {
            self.context = [[UILabel alloc] initWithFrame:CGRectMake(75, 30, 200, 25)];
            self.context.font = [UIFont systemFontOfSize:17];
            //self.context.text = self.myname;
            [self.contentView addSubview:self.context];
            
        }
    }
    return self;
}

-(void)setUser:(RecentEntity*)recent{

    if(recent.userType == UserType_Player){

        UserEntity* user = [[UserMng shareInstance]getUser:recent.uid];
        if (user){
                [self.name setText:user.name];
                [self.context setText:user.uid];
                [self.icon setImage:[UIImage imageNamed:@"my_selected"]];
        }


    }else if(recent.userType == UserType_System){


    }


}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (CGFloat)cellHeight{
    return 61;
}
@end
