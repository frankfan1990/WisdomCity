
//这样，当应用发生错误而产生上述Signal后，就将会进入我们自定义的回调函数MySignalHandler。为了得到崩溃时的现场信息，还可以加入一些获取CallTrace及设备信息的代码，.mm文件的完整代码如下：

#import "UncaughtExceptionHandler.h"

#include <libkern/OSAtomic.h>

#include <execinfo.h>

NSString * const UncaughtExceptionHandlerSignalExceptionName = @"UncaughtExceptionHandlerSignalExceptionName";

NSString * const UncaughtExceptionHandlerSignalKey = @"UncaughtExceptionHandlerSignalKey";

NSString * const UncaughtExceptionHandlerAddressesKey = @"UncaughtExceptionHandlerAddressesKey";

volatile int32_t UncaughtExceptionCount = 0;

const int32_t UncaughtExceptionMaximum = 10;

const NSInteger UncaughtExceptionHandlerSkipAddressCount = 4;

const NSInteger UncaughtExceptionHandlerReportAddressCount = 5;

@implementation UncaughtExceptionHandler

+ (NSArray *)backtrace

{
    
    void* callstack[128];
    
    int frames = backtrace(callstack, 128);
    
    char **strs = backtrace_symbols(callstack, frames); 
    
    int i;
    
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    
    for (
         
         i = UncaughtExceptionHandlerSkipAddressCount;
         
         i < UncaughtExceptionHandlerSkipAddressCount +
         
         UncaughtExceptionHandlerReportAddressCount;
         
         i++)
        
    {
        
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
        
    }
    
    free(strs); 
    
    return backtrace;
    
}

- (void)alertView:(UIAlertView *)anAlertView clickedButtonAtIndex:(NSInteger)anIndex

{
    
    if (anIndex == 0)
        
    {
        
        dismissed = YES;
        
    }
    
}
-(void)emailToDevelpoer:(NSException *)exception{
//    NSArray *arr = [exception callStackSymbols];
//	NSString *reason = [exception reason];
//	NSString *name = [exception name];
//	
//	NSString *urlStr = [NSString stringWithFormat:@"mailto://harrylv@dingtai.biz?subject=bug报告&body=感谢您的配合!<br><br><br>"
//						"错误详情:<br>%@<br>--------------------------<br>%@<br>---------------------<br>%@", 
//						name,reason,[arr componentsJoinedByString:@"<br>"]];
//	
//	NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//	[[UIApplication sharedApplication] openURL:url];
    
}

- (void)handleException:(NSException *)exception

{
    
    UIAlertView *alert =
    
    [[[UIAlertView alloc]
      
      initWithTitle:NSLocalizedString(@"提示", nil)
      
      message:[NSString stringWithFormat:NSLocalizedString(
                                                           
                                                           @"您的网络好像不给力哦,你可以选择退出或继续!"
                                                           
                                                           , nil),
               
               [exception reason],
               
               [[exception userInfo] objectForKey:UncaughtExceptionHandlerAddressesKey]]
      
      delegate:self
      
      cancelButtonTitle:NSLocalizedString(@"退出", nil)
      
      otherButtonTitles:NSLocalizedString(@"继续", nil), nil]
     
     autorelease];
    
    [alert show];
    
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    
    CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
    
    while (!dismissed)
        
    {
        
        for (NSString *mode in (NSArray *)allModes)
            
        {
            
            CFRunLoopRunInMode((CFStringRef)mode, 0.001, false);
            
        }
        
    }
    
    CFRelease(allModes);
    
    NSSetUncaughtExceptionHandler(NULL);
    
    signal(SIGABRT, SIG_DFL);
    
    signal(SIGILL, SIG_DFL);
    
    signal(SIGSEGV, SIG_DFL);
    
    signal(SIGFPE, SIG_DFL);
    
    signal(SIGBUS, SIG_DFL);
    
    signal(SIGPIPE, SIG_DFL);
    
    if ([[exception name] isEqual:UncaughtExceptionHandlerSignalExceptionName])
        
    {
        
        kill(getpid(), [[[exception userInfo] objectForKey:UncaughtExceptionHandlerSignalKey] intValue]);
        
    }
    
    else
        
    {
        
        [exception raise];
        
    }
    
}

@end

NSString* getAppInfo()

{
    
    NSString *appInfo = [NSString stringWithFormat:@"App : %@ %@(%@)\nDevice : %@\nOS Version : %@ %@",
                         
                         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"],
                         
                         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"],
                         
                         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"],
                         
                         [UIDevice currentDevice].model,
                         
                         [UIDevice currentDevice].systemName,
                         
                         [UIDevice currentDevice].systemVersion];
    
    NSLog(@"Crash!!!! %@", appInfo);
    
    return @"";
    
}

void MySignalHandler(int signal)

{
    
    int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount);
    
    if (exceptionCount > UncaughtExceptionMaximum)
        
    {
        
        return;
        
    }
    
    
    
    NSMutableDictionary *userInfo =
    
    [NSMutableDictionary
     
     dictionaryWithObject:[NSNumber numberWithInt:signal]
     
     forKey:UncaughtExceptionHandlerSignalKey];
    
    NSArray *callStack = [UncaughtExceptionHandler backtrace];
    
    [userInfo
     
     setObject:callStack
     
     forKey:UncaughtExceptionHandlerAddressesKey];
    
    [[[[UncaughtExceptionHandler alloc] init] autorelease]
     
     performSelectorOnMainThread:@selector(handleException:)
     
     withObject:
     
     [NSException
      
      exceptionWithName:UncaughtExceptionHandlerSignalExceptionName
      
      reason:
      
      [NSString stringWithFormat:
       
       NSLocalizedString(@"Signal %d was raised.\n"
                         
                         @"%@", nil),
       
       signal, getAppInfo()]
      
      userInfo:
      
      [NSDictionary
       
       dictionaryWithObject:[NSNumber numberWithInt:signal]
       
       forKey:UncaughtExceptionHandlerSignalKey]]
     
     waitUntilDone:YES];
    
}

void InstallUncaughtExceptionHandler()

{
    
    signal(SIGABRT, MySignalHandler);
    
    signal(SIGILL, MySignalHandler);
    
    signal(SIGSEGV, MySignalHandler);
    
    signal(SIGFPE, MySignalHandler);
    
    signal(SIGBUS, MySignalHandler);
    
    signal(SIGPIPE, MySignalHandler);
    
}