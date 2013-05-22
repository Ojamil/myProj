//
//  JoinUpViewController.m
//  myProj
//
//  Created by sky on 13-5-19.
//
//

#import "JoinUpViewController.h"
#import "ApplicationSendViewController.h"
#import "Networking.h"
@interface UIViewController ()

@end

@implementation JoinUpViewController
@synthesize applyReason;
@synthesize aname,anameLabel;
@synthesize aid;

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
    
    UIButton *leftButton = [[UIButton alloc] init];
    leftButton.frame = CGRectMake(0,0,20,20);
    [leftButton setBackgroundImage:[UIImage imageNamed: @"back.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    /*
    CGRect back = CGRectMake(0, 0, 320, 460);
    UIImageView *view = [[UIImageView alloc]initWithFrame:back];
    UIImage *image = [UIImage imageNamed:@"bg.jpg"];
    [view setImage:image];
    [self.view addSubview:view];
    [self.view sendSubviewToBack:view];
     */
    
    anameLabel.text = aname;
        
    self.applyReason.returnKeyType = UIReturnKeyDefault;//返回键的类型
    
    self.applyReason.keyboardType = UIKeyboardTypeDefault;//键盘类型
    
    self.applyReason.scrollEnabled = YES;//是否可以拖动
    self.applyReason.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    
    UIColor *color = [UIColor colorWithRed:0.3 green:0.9 blue:0.2 alpha:0.65];
    [self.applyReason setBackgroundColor:color];
    self.applyReason.alpha= 0.5;
    [self.view addSubview: self.applyReason];//加入到整个页面中
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setApplyReason:nil];

    [self setAname:nil];
    [super viewDidUnload];
}
- (IBAction)send:(id)sender {
    
    
    
    //获取当前用户uid
    NSDictionary *userInfo = [localSQL getLocalUserInfo];
    NSString *uid = [userInfo objectForKey:@"uid"];
    
    XYLoadingView *loadingView = XYShowLoading(@"正在提交……");
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          uid, @"uid",self.aid,@"aid",applyReason.text,@"reason",
                          nil];
    Networking *net = [[Networking alloc]initWithPhp:@"join_activity.php" method:@"POST" parameters:dict];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:net.request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        
        [loadingView performSelector:@selector(dismiss) withObject:nil];
        
        ApplicationSendViewController* applicationSend= [self.storyboard instantiateViewControllerWithIdentifier:@"ApplicationSend"];
        [self presentModalViewController:applicationSend animated:YES];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
        [loadingView performSelector:@selector(dismiss) withObject:nil];
        XYShowAlert(@"网络连接失败！");
        
    }];
    
    [operation start];
}
- (IBAction)backgroundTap:(id)sender
{
    [self.view endEditing:YES];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
