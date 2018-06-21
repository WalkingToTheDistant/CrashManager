# CrashManager
文档说明：http://www.jianshu.com/p/3ae2f9589fae 

目前只是处理了NSArray、NSMutableArray、NSDictionary和NSMutableDictionary的部分成员方法，避免其因为操作失误造成Crash。可以在各个文件.m的crashSafe_*****方法里面收集Crash原因。
要使用这个功能，需要调用 CrashPublic.h 里面的initCrashCategory方法启动，这个方法里面初始化各个Crash分类，可以在- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions里面执行。
