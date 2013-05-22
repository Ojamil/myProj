//
//  WelcomeViewController.m
//  myProj
//
//  Created by sky on 13-5-16.
//
//

#import "WelcomeViewController.h"
#import "localSQL.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    [background setImage:[UIImage imageNamed:@"loading.png"]];
    [self.view addSubview:background];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self loading];
}

- (void)loading
{
    //用户信息已存在,将用户信息
    if ([localSQL checkIfExists])
    {
        sleep(2);
        //将用户信息载入，并直接跳入主页
        MainTabBarViewController *success = [self.storyboard instantiateViewControllerWithIdentifier:@"MainTabBar"];
        success.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
        [self presentModalViewController:success animated:YES];
    }
    else
    {
        sleep(2);
        //跳转到login页面
        LoginPageViewController *success = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginPage"];
        success.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
        [self presentModalViewController:success animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
