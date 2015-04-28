//
//  ViewController.m
//  javascriptDemo
//
//  Created by 化召鹏 on 13-11-21.
//  Copyright (c) 2013年 化召鹏. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    int x=[UIScreen mainScreen].bounds.origin.x;
    int y=[UIScreen mainScreen].bounds.origin.y;
    int w=[UIScreen mainScreen].bounds.size.width;
    int h=[UIScreen mainScreen].bounds.size.height;
    
//    NSString *manPath=[[NSBundle mainBundle] pathForResource:@"man.html" ofType:nil];
    NSString *url = @"http://m.tuanche.com/bj?bd_id=3Fdda17af8962c3da5a26b9afb070a445e";
    
    UIImageView *imgV=[[UIImageView alloc] initWithFrame:CGRectMake(0, 20, w, 44)];
    imgV.image=[UIImage imageNamed:@"top_bg.png"];
    imgV.backgroundColor=[UIColor clearColor];
    [self.view addSubview:imgV];
    
    UIButton *butt=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    butt.frame=CGRectMake(w-60-10, 20+2, 60, 40);
    [butt setTitle:@"切换" forState:UIControlStateNormal];
    [butt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [butt addTarget:self action:@selector(buttClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:butt];
    
    _webV=[[UIWebView alloc] initWithFrame:CGRectMake(x, y+20+44, w, h-20)];
    _webV.delegate=self;
    _webV.userInteractionEnabled=YES;
    _webV.scalesPageToFit=YES;
    //_webV.backgroundColor=[UIColor clearColor];
    [_webV loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:url]]];
    [self.view addSubview:_webV];
    
    
}

-(void)buttClick:(id)sender{
    
    UIButton *butt=(UIButton *)sender;
    
    
    NSDictionary *dict1=[[NSDictionary alloc] initWithObjectsAndKeys:@"男",@"name",@"2",@"value",@"#E60A1E",@"color", nil];
    NSDictionary *dict2=[[NSDictionary alloc] initWithObjectsAndKeys:@"女",@"name",@"23",@"value",@"#FFC441",@"color", nil];
    NSArray *array=[[NSArray alloc] initWithObjects:dict1,dict2,nil];
    
    

    //封装json
    NSData *data=[NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *str=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",str);
    
    
    //调用页面的setNewData方法.传入值
    NSString *dataStr=[NSString stringWithFormat:@"setNewData(%@)",str];
    [_webV stringByEvaluatingJavaScriptFromString:dataStr];
    
    if (butt.selected) {
        NSString *manPath=[[NSBundle mainBundle] pathForResource:@"man.html" ofType:nil];
        [_webV loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:manPath]]];
    }else{
        NSString *yuanzhuPath=[[NSBundle mainBundle] pathForResource:@"yuanzhu3D" ofType:@"html"];
        [_webV loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:yuanzhuPath]]];
    }
    butt.selected=!butt.selected;
    
//    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"这是ios7" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//    
//    [alert setAlertViewStyle:UIAlertViewStyleSecureTextInput];
//    [alert show];
//    
//    for (UIView * v in [alert subviews]) {
//        NSLog(@"%@",v);
//    }
    
}
#pragma mark- UIWebView delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    
    NSLog(@"%ld",navigationType);

    NSString *urlStr = [[request URL] absoluteString];
    NSArray *urlComps = [urlStr componentsSeparatedByString:@"://"];
    NSLog(@"urlComps ===%@",urlComps);
    if ([urlComps count]&&[[urlComps objectAtIndex:0] isEqualToString:@"objc"]) {
        NSLog(@"object");
    }
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    

}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
 
//    NSDictionary *dict1=[[NSDictionary alloc] initWithObjectsAndKeys:@"男",@"name",@"2",@"value",@"#E60A1E",@"color", nil];
//    NSDictionary *dict2=[[NSDictionary alloc] initWithObjectsAndKeys:@"女",@"name",@"23",@"value",@"#FFC441",@"color", nil];
//    NSArray *array=[[NSArray alloc] initWithObjects:dict1,dict2,nil];
//    
//    
//    
//    NSData *data=[NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
//    
//    NSString *str=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    
//    NSLog(@"%@",str);
//    
//    NSString *dataStr=[NSString stringWithFormat:@"setNewData(%@)",str];
//    [webView stringByEvaluatingJavaScriptFromString:dataStr];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
