//
//  ActivitiesDetailsViewController.h
//  myProj
//
//  Created by sky on 13-4-29.
//
//

#import <UIKit/UIKit.h>
#import "JoinUpViewController.h"
#import "VerticallyAlignedLabel.h"
@interface ActivitiesDetailsViewController : UIViewController<UIScrollViewDelegate>

@property(nonatomic,retain) IBOutlet UIScrollView *myscrollview;
@property (nonatomic,retain) NSString *aid;
@property (nonatomic,retain) NSString *aname;
@property (nonatomic,retain) NSString *timeBegin;
@property (nonatomic,retain) NSString *timeEnd;
@property (nonatomic,retain) NSString *address;
@property (nonatomic,retain) NSString *acondition;
@property (nonatomic,retain) NSString *maxNum;
@property (nonatomic,retain) NSString *aabs;
@property (nonatomic,retain) NSString *aintro;
@property (nonatomic,retain) NSString *ajoined;
@property (nonatomic,retain) NSString *aclick;
@property (nonatomic,retain) NSString *applyDeadline;
@property (nonatomic,retain) NSString *apublic;
@property (nonatomic,retain) NSString *cid;

@property (nonatomic,retain) IBOutlet UILabel *aidLabel;
@property (nonatomic,retain) IBOutlet UILabel *anameLabel;
@property (nonatomic,retain) IBOutlet UILabel *timeBeginLabel;
@property (nonatomic,retain) IBOutlet UILabel *timeEndLabel;
@property (nonatomic,retain) IBOutlet UILabel *addressLabel;
@property (nonatomic,retain) IBOutlet UILabel *aconditionLabel;
@property (nonatomic,retain) IBOutlet UILabel *maxNumLabel;
@property (nonatomic,retain) IBOutlet UILabel *aabsLabel;
@property (strong, nonatomic) VerticallyAlignedLabel *aintroLabel;


@property (nonatomic,retain) IBOutlet UILabel *ajoinedLabel;
@property (nonatomic,retain) IBOutlet UILabel *aclickLabel;
@property (nonatomic,retain) IBOutlet UILabel *applyDeadlineLabel;
@property (nonatomic,retain) IBOutlet UILabel *apublicLabel;
@property (nonatomic,retain) IBOutlet UILabel *cidLabel;

- (IBAction)back:(id)sender;
- (IBAction)send:(id)sender;

@end
