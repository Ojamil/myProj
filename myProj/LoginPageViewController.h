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
#import "Networking.h"

@class LoginPageViewController;



@interface LoginPageViewController : UIViewController <SignUpViewControllerDelegate,MainTabBarViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *password;

@property (strong, nonatomic) UITabBarController *tabController;
@property (strong,nonatomic)  XYLoadingView *loadingView;   //controller中不同函数间loadingView的传递

- (IBAction)formalLogIn:(id)sender;

- (IBAction)testFieldDoneEditing:(id)sender ;
- (IBAction)guestLogIn:(id)sender;


- (IBAction)backgroundTap:(id)sender;
@end
