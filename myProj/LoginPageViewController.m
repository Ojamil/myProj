//
//  LoginPageViewController.m
//  myProj
//
//  Created by sky on 13-5-8.
//
//

#import "LoginPageViewController.h"

@interface LoginPageViewController ()

@end

@implementation LoginPageViewController
@synthesize tabController;
@synthesize email,password;
@synthesize loadingView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect back = CGRectMake(0, 0, 320, 480);
    UIImageView *view = [[UIImageView alloc]initWithFrame:back];
    UIImage *image = [UIImage imageNamed:@"login_background.jpg"];
    [view setImage:image];
    [self.view addSubview:view];
    [self.view sendSubviewToBack:view];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setEmail:nil];
    [self setPassword:nil];
    [super viewDidUnload];
}



#pragma mark - SignUpViewControllerDelegate

- (void)SignUpViewControllerDidCancel:
(SignUpViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)SignUpViewControllerDidSave:
(SignUpViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"SignUp"])
	{
        SignUpViewController *SignUpViewController = segue.destinationViewController;
        SignUpViewController.delegate = self;
	}
   
}

//注册用户登录
- (IBAction)formalLogIn:(id)sender {
    [self login:1];
}

//试用用户登录
- (IBAction)guestLogIn:(id)sender {
    [self login:0];
}

- (void)login:(int)type
{
    NSString *str1;
    NSString *str2;
    
    if (type == 1)  //1表示正常登录
    {
        str1=email.text;
        str2=password.text;
    }
    else    //不是1表示试用登录
    {
        //试用账号
         str1=@"f";
         str2=@"f";
    }

    if(str1.length == 0)
    {
        XYShowAlert(@"用户名不能为空");
        return;
    }
    else if(str2.length == 0)
    {
        
        XYShowAlert(@"密码不能为空");
        return;
    }
     loadingView = XYShowLoading(@"正在登录……");
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          str1, @"email",str2,@"password",
                          nil];
    Networking *net = [[Networking alloc]initWithPhp:@"login.php" method:@"POST" parameters:dict];
    
    [net setJsonRequestForObject:self ifSuccess:@selector(connectionSuccess:) ifFailure:@selector(connectionFailure)];
    
}

//网络连接成功函数
- (void)connectionSuccess:(id)JSON
{
    NSLog(@"%@",JSON);
    NSString *message=[JSON objectForKey:@"msg"];
    
    if([message isEqualToString:@"Accepted"])
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[JSON objectForKey:@"inf"]];
        
        Networking *net = [[Networking alloc]initWithPhp:@"login.php" method:@"POST" parameters:dict];
        [self getCloudUserInfo:dict];
        [net getCloudActInfoWithSelector:@selector(change2Main) by:self];
    }
    else //用户名密码输入错误
    {
        [loadingView performSelector:@selector(dismiss) withObject:nil];
        XYShowAlert(@"用户名或密码错误~");
    }
}

//网络连接失败函数
- (void)connectionFailure
{
    [loadingView performSelector:@selector(dismiss) withObject:nil];
    XYShowAlert(@"网络故障，无法登录~");
}

//login的时候更新个人数据并存到本地plist文件中
- (void)getCloudUserInfo:(NSDictionary *)dict
{
    [localSQL creatLocalUserInfo:dict];
}

//跳转到主界面函数
- (void)change2Main
{
    //关闭提示信息并进入主界面
    [loadingView performSelector:@selector(dismiss) withObject:nil];
    MainTabBarViewController *success=[self.storyboard instantiateViewControllerWithIdentifier:@"MainTabBar"];
    success.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:success animated:NO];
}

- (IBAction)testFieldDoneEditing:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)backgroundTap:(id)sender
{
    [self.view endEditing:YES];
}
@end
