//
//  PickCityViewController.h
//  myProj
//
//  Created by sky on 13-5-16.
//
//

#import <UIKit/UIKit.h>

@class PickCityViewController;

@protocol PickCityViewDelegate
- (void)setValue:(NSString *)value;
@end

@interface PickCityViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSString* city;
    id<PickCityViewDelegate> passDelegate;
}
@property(nonatomic, retain) id<PickCityViewDelegate> passDelegate;
@property(nonatomic, strong) NSString* city;
@property(nonatomic, retain) NSArray *keys;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)PickOk:(id)sender;
- (IBAction)back:(id)sender;

@end
