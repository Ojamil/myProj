//
//  ActivitiesViewController.h
//  myProj
//
//  Created by sky on 13-5-15.
//
//

#import <UIKit/UIKit.h>
#import "PickCityViewController.h"


@interface ActivitiesViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,PickCityViewDelegate>
{
    NSString* city;
}

@property(nonatomic, strong)NSMutableArray *data;//data代表活动列表，存each
@property(nonatomic, strong)NSString* aname;
@property(nonatomic, strong)NSString* aabs;
@property(nonatomic, strong)NSString* aclick;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITextField *searchField;

- (void) setValue:(NSString *) value;

- (IBAction)textFieldDoneEditing:(id)sender;
- (IBAction)refresh:(id)sender;
- (IBAction)pickCity:(id)sender;
@end
