//
//  ContactCell.m
//  iOSDemo
//
//  Created by 周维 on 17/2/22.
//  Copyright © 2017年 chaw. All rights reserved.
//
#import "UserEntity.h"
#import "ContactCell.h"
@interface ContactCell ()
@property (strong, nonatomic) UIImageView* icon;
@property (strong, nonatomic) UILabel* name, *context, *time;
@property (copy, nonatomic) NSString* myname;
@end
@implementation ContactCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if (!self.icon) {
            self.icon = [[UIImageView alloc ] initWithFrame:CGRectMake(10, ([ContactCell cellHeight]-48)/2, 48, 48) ];
            [self.contentView addSubview:self.icon];
        }
        if (!self.name) {
            self.name = [[UILabel alloc] initWithFrame:CGRectMake(75, 8, 200, 25)];
            self.name.font = [UIFont systemFontOfSize:17];
            [self.contentView addSubview:self.name];
            
        }
   
    }
    return self;
}
-(void)setUser:(UserEntity*)user{
    [self.name setText:user.name];
   // [self.context setText:user.uid];
    [self.icon setImage:[UIImage imageNamed:@"my_selected"]];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (CGFloat)cellHeight{
    return 61;
}
@end
