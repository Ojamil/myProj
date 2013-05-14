//
//  LoginPageViewController.h
//  myProj
//
//  Created by sky on 13-5-8.
//
//

#import <UIKit/UIKit.h>
#import "SignUpViewController.h"
#import "MainTabBarViewController.h"

@interface LoginPageViewController : UIViewController <SignUpViewControllerDelegate,MainTabBarViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *password;

@property (strong, nonatomic) UITabBarController *tabController;



@end
