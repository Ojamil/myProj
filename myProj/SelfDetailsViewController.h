//
//  SelfDetailsViewController.h
//  myProj
//
//  Created by sky on 13-5-14.
//
//

#import <UIKit/UIKit.h>

@interface SelfDetailsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *school;
@property (strong, nonatomic) IBOutlet UILabel *apublic;
@property (strong, nonatomic) IBOutlet UILabel *gender;
@property (strong, nonatomic) IBOutlet UILabel *birthdate;
@property (strong, nonatomic) IBOutlet UILabel *mob;
@property (strong, nonatomic) IBOutlet UILabel *email;

- (IBAction)back:(id)sender;

@end
