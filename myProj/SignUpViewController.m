//
//  SignUpViewController.m
//  myProj
//
//  Created by sky on 13-5-8.
//
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController
@synthesize email,password,password2,name,telephone,school,qq,birthdate,intro,city,gender;

@synthesize delegate;
@synthesize myscrollview;

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
    
    [[self view]setBackgroundColor:[UIColor blackColor]];
    
    myscrollview.frame = CGRectMake(0,44,320,568);
    [myscrollview setContentSize:CGSizeMake(320,920)];
    myscrollview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_background.png"]];
    myscrollview.directionalLockEnabled = YES; //只能一个方向滑动
    myscrollview.pagingEnabled = NO; //是否翻页

    myscrollview.showsVerticalScrollIndicator =YES; //垂直方向的滚动指示
    myscrollview.indicatorStyle = UIScrollViewIndicatorStyleWhite;//滚动指示的风格
    myscrollview.showsHorizontalScrollIndicator = NO;//水平方向的滚动指示
    myscrollview.delegate = self;
    
     //[self.view addSubview:myscrollview];
	// Do any additional setup after loading the view.
    [self.photoView setImage:[UIImage imageNamed:@"default_user_photo.jpg"]];
    self.photoView.userInteractionEnabled = YES;
    
    
    CALayer *layer = [self.photoView layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:10.0];
    [layer setBorderWidth:1];
    
    self.photoView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.photoView.layer.shadowOffset = CGSizeMake(10, 10);
    self.photoView.layer.shadowOpacity = 0.5;
    self.photoView.layer.shadowRadius = 10.0;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uploadPhoto:)];
    [self.photoView addGestureRecognizer:singleTap];
    school.delegate = self;
    email.delegate = self;
    password.delegate = self;
    password2.delegate = self;
    name.delegate = self;
    telephone.delegate = self;
    qq.delegate = self;
    birthdate.delegate = self;
    intro.delegate = self;
    city.delegate = self;
    gender.delegate = self;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidUnload {
    [self setEmail:nil];
    [self setPassword:nil];
    [self setPassword2:nil];
    [self setName:nil];
    [self setTelephone:nil];
    myscrollview=nil;
    [self setGender:nil];
    [self setSchool:nil];
    [self setBirthdate:nil];
    [self setTelephone:nil];
    [self setIntro:nil];
    [self setCity:nil];
    [self setQq:nil];
    [super viewDidUnload];
}

- (IBAction)testFieldDoneEditing:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)backgroundTap:(id)sender
{
    [self.view endEditing:YES];
}

- (IBAction)send:(id)sender {
    NSString *str1=email.text;
    NSString *str2=password.text;
    NSString *str22=password2.text;
    NSString *str3=name.text;
    NSString *str4=gender.text;
    NSString *str5=birthdate.text;
    NSString *str6=telephone.text;
    NSString *str7=intro.text;
    NSString *str8=city.text;
    NSString *str9=telephone.text;
    NSString *str10=qq.text;
    NSString *str11=[Photo image2String:self.photo];
    NSString *str12=school.text;
    
    if(![str2 isEqualToString:str22])
    {
        NSLog(@"%@",password.text);
        NSLog(@"%@",password2.text);
        XYShowAlert(@"两次密码输入不匹配哦><");
    }
    
    XYLoadingView *loadingView = XYShowLoading(@"正在注册……");
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          str1, @"email",str2,@"password",str3,@"uname",str4,@"gender",str5,@"birthdate",str6,@"tel",str7,@"selfIntroduction",str8,@"city",str9,@"mob",str10,@"qq",str11,@"photo",str12,@"sid",
                          nil];
    Networking *net = [[Networking alloc]initWithPhp:@"register.php" method:@"POST" parameters:dict];
   
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:net.request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
            NSString *message=[JSON objectForKey:@"msg"];
        NSLog(@"%@",message);
        [loadingView performSelector:@selector(dismiss) withObject:nil];
        
        if([message isEqualToString:@"Success"])
        {
            [loadingView performSelector:@selector(dismiss) withObject:nil];

            SignUpSuccessViewController *success=[self.storyboard instantiateViewControllerWithIdentifier:@"SignUpSuccessIden"];
            success.myName.text=str3;
            [self presentModalViewController:success animated:YES];
        }
        else if([message isEqualToString:@"Existed"])
        {
            [loadingView performSelector:@selector(dismiss) withObject:nil];

            XYShowAlert(@"该用户名以使用，换一个试试吧:)");
        }
        else 
        {
            [loadingView performSelector:@selector(dismiss) withObject:nil];

            XYShowAlert(@"注册失败了TT");
        }
         
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        [loadingView performSelector:@selector(dismiss) withObject:nil];

        XYShowAlert(@"网络连接失败！");
    }];
    
    [operation start];//一定有
}


- (IBAction)back:(id)sender {
    
    [self.delegate SignUpViewControllerDidCancel:self];
}

//上传头像按钮
- (IBAction)uploadPhoto:(id)sender {
    
    UIActionSheet *actionSheet =
    [[UIActionSheet alloc] initWithTitle:@"图片上传方式"
                                delegate:self
                       cancelButtonTitle:@"取消"
                  destructiveButtonTitle:nil
                       otherButtonTitles:@"拍照",@"从手机相册选择",nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //启动照相模式
    if (buttonIndex == 0) {
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentModalViewController:picker animated:YES];
    }
    //从相册选取
    else if (buttonIndex ==1)
    {
        UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //pickerImage.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
            
        }
        pickerImage.delegate = self;
        pickerImage.allowsEditing = NO;
        [self presentModalViewController:pickerImage animated:YES];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 图片在这里
    self.photo = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.photoView setImage:self.photo];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - scroll view delegate

-(void)scrollViewDidScroll:(UIScrollView*)scrollView

{
    //页面滚动时调用，设置当前页面的ID
    //[_pageControl setCurrentPage:fabs(scrollView.contentOffset.x/self.view.frame.size.width)];
    NSLog(@"视图滚动中X轴坐标%f",scrollView.contentOffset.x);
    NSLog(@"视图滚动中Y轴坐标%f",scrollView.contentOffset.y);
}

#pragma mark - keyboard adjusting

// Called when the UIKeyboardDidShowNotification is sent.
- (void)viewWillAppear:(BOOL)animated
{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
   
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
	[super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[super viewWillDisappear:animated];
}

- (void)keyboardWillHide:(id)sender {
    
	UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    myscrollview.contentInset = contentInsets;
    myscrollview.scrollIndicatorInsets = contentInsets;
}
- (void)keyboardWillShow:(id)sender {
    NSLog(@"%@",sender);
	NSDictionary * info = [sender userInfo];
	NSValue * value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
	CGSize keyboardSize = [value CGRectValue].size;
    CGRect aRect = self.view.frame;
    aRect.size.height -= keyboardSize.height;
    aRect.size.height -= activeField.frame.size.height;
    if(!CGRectContainsPoint(aRect, activeField.frame.origin) ) 
	{
        [myscrollview setContentOffset: CGPointMake(myscrollview.contentOffset.x,activeField.frame.origin.y-keyboardSize.height+activeField.frame.size.height) animated:YES];
    }
}

#pragma mark - text field delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
    NSLog(@"%@",activeField);
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField = nil;
}

@end
