//
//  SelfViewController.h
//  myProj
//
//  Created by sky on 13-5-7.
//
//

#import <UIKit/UIKit.h>
#import "SelfActivitiesCellStyle.h"
#import "SelfActivitiesDetailsViewController.h"
@interface SelfViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate>


@property(nonatomic, retain)NSDictionary *each;//key
@property(nonatomic, retain)NSMutableArray *data;//dataset

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *schoolLabel;
@property (strong, nonatomic) IBOutlet UILabel *hourLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)LogOut:(id)sender;
- (IBAction)SelfDetail:(id)sender;


@end
