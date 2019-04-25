//This is explanatory notes 
#import "MainUIWebViewController.h"


//This is explanatory notes 
@interface MainUIWebViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webTop;
@property (weak, nonatomic) IBOutlet UIWebView *mainWebview;
//This is explanatory notes 
@end
//This is explanatory notes 
@implementation MainUIWebViewController
//This is explanatory notes 
- (void)viewDidLoad {
    [super viewDidLoad];
//This is explanatory notes
    
    if (@available(iOS 11.0, *)) {
        if ([UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom > 0) {
            self.webTop.constant = 44;
        }
    } else {
        self.webTop.constant = 20;
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_linkUrl]];
    [self.mainWebview loadRequest:request];
//This is explanatory notes 
}
//This is explanatory notes 
+ (BOOL)todaywhich:(CGFloat)right bring:(NSData *)shall rightexpress:(UITableViewCell *)skill{
   BOOL carryycz_prebl225 = arc4random_uniform(2);
  return carryycz_prebl225;
}
@end
   

