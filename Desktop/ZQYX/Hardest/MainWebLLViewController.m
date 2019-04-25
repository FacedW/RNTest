//This is explanatory notes 
#import "MainWebLLViewController.h"
#import <WebKit/WebKit.h>
//This is explanatory notes
@interface MainWebLLViewController ()<WKScriptMessageHandler, WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
@end
//This is explanatory notes 
@implementation MainWebLLViewController
//This is explanatory notes 
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadWkwebviewconfig];
    [self loadWebUrl];
}
//This is explanatory notes 
-(void)loadWkwebviewconfig
{
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
//This is explanatory notes 
    config.preferences = [[WKPreferences alloc] init];
//This is explanatory notes 
    config.preferences.minimumFontSize = 10;
//This is explanatory notes 
    config.preferences.javaScriptEnabled = YES;
//This is explanatory notes 
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
//This is explanatory notes 
    config.processPool = [[WKProcessPool alloc]init];
//This is explanatory notes 
    config.userContentController = [[WKUserContentController alloc] init];
//This is explanatory notes
    
    CGFloat statusBarHeight = 20;
    if (@available(iOS 11.0, *)) {
        if ([UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom > 0) {
            statusBarHeight = 44;
        }
    }
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, statusBarHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - statusBarHeight) configuration:config];
    [self.view addSubview:self.webView];
//This is explanatory notes 
    self.webView.navigationDelegate = self;
}
//This is explanatory notes 
- (void)loadWebUrl {
    NSString *urlLinStr = [_linkUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlLinStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    [_webView loadRequest:request];
}
//This is explanatory notes 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
//This is explanatory notes 
}
//This is explanatory notes 
#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
//This is explanatory notes 
}
//This is explanatory notes 
#pragma mark - WKNavigationDelegate
//This is explanatory notes 
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}
//This is explanatory notes 
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
}
//This is explanatory notes 
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
}
//This is explanatory notes 
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
//This is explanatory notes 
}
//This is explanatory notes 
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
//This is explanatory notes 
}
//This is explanatory notes 
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
}
//This is explanatory notes 
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
}
//This is explanatory notes 
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
//This is explanatory notes 
}
//This is explanatory notes 
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
}
//This is explanatory notes 
- (UIImageView *)expect:(NSString *)start{
   UIImageView* writeycz_prebl225 = [UIImageView new];
  return writeycz_prebl225;
}
- (int)theirthosewrite:(UIImageView *)program{
   int sleepycz_prebl225 = arc4random_uniform(100);
  return sleepycz_prebl225;
}
- (CGFloat)myselfexpress:(UIViewController *)sight{
   CGFloat bringycz_prebl225 = arc4random_uniform(100) / 2.0;
   return bringycz_prebl225;
}
- (int)write:(UIViewController *)light thesebringexpect:(int)carry command:(NSData *)which{
   int foundycz_prebl225 = arc4random_uniform(100);
  return foundycz_prebl225;
}
- (BOOL)express:(UIImage *)sleep{
   BOOL becauseycz_prebl225 = arc4random_uniform(2);
  return becauseycz_prebl225;
}
@end
   

