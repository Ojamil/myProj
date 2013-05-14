//
//  SelfActivitiesCellStyle.h
//  myProj
//
//  Created by sky on 13-5-7.
//
//

#import <UIKit/UIKit.h>

@interface SelfActivitiesCellStyle : UITableViewCell
@property (copy, nonatomic) NSString *newsTitle;
@property (copy, nonatomic) NSString *newsSubtitle;
@property (copy, nonatomic) NSNumber *clickNum;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *clickLabel;


@end
