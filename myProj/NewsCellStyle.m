//
//  NewsCellStyle.m
//  myProj
//
//  Created by sky on 13-5-2.
//
//

#import "NewsCellStyle.h"

@implementation NewsCellStyle
@synthesize newsTitle,newsSubtitle,titleLabel,subtitleLabel,clickLabel,clickNum;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
