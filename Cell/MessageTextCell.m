//
//  MessageTextCell.m
//  iOSDemo
//
//  Created by 周维 on 17/3/1.
//  Copyright © 2017年 chaw. All rights reserved.
//

#import "MessageTextCell.h"
#import "MessageEntity.h"
#import <Masonry/Masonry.h>

static const int fontsize = 16;
@implementation MessageTextCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.userContent setBackgroundColor:[UIColor clearColor]];
        [self.userContent setUserInteractionEnabled:YES];
        [self.userContent setFont:[UIFont systemFontOfSize:fontsize]];
        [self.userContent setNumberOfLines:0];
        [self.contentView addSubview:self.userContent];
        
    }
    return self;
}
-(void)setContent:(MessageEntity*)message{
    [super setContent:message];
    
    [self.userContent setTextColor:[UIColor redColor]];
    [self.userContent setText:message.msgContent];
    
}
#pragma mark  ChatCellProtocol

- (CGSize)sizeForContent:(MessageEntity*)message{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    NSDictionary *attribute = @{NSFontAttributeName : [UIFont systemFontOfSize:fontsize],
                                      NSParagraphStyleAttributeName : paragraphStyle};
                                      
    CGSize textSize = [self boundingRectWithSize:CGSizeMake(self.view.frame.size.width-20, CGFLOAT_MAX) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;

    return CGSizeMake(ceil(textSize.width), ceil(textSize.height));
}

- (CGFloat)contentUpGapWithBubble{
    return 0;
    
}

- (CGFloat)contentDownGapWithBubble{
    return 0;
    
}

- (CGFloat)contentLeftGapWithBubble{
    return 0;
    
}

- (CGFloat)contentRightGapWithBubble{
    return 0;
    
}

- (void)layoutContentView:(MessageEntity*)message{
    
    
}

- (CGFloat)cellHeightForMessage:(MessageEntity*)message{
    CGSize size = [self sizeForContent:message];
    CGFloat height = size.height + [self contentDownGapWithBubble] + [self contentUpGapWithBubble];
    return height;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
