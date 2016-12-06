//
//  HWLog.h
//  TemplateTest
//
//  Created by caijingpeng.haowu on 15/4/15.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#ifndef TemplateTest_HWLog_h
#define TemplateTest_HWLog_h

#define NEED_DEBUG

#ifdef NEED_DEBUG
#define NSLog(format, ...) \
do { \
NSLog(@"<%@ : %d : %s>-: %@", \
[[NSString stringWithUTF8String:__FILE__] lastPathComponent], \
__LINE__, \
__FUNCTION__, \
[NSString stringWithFormat:format, ##__VA_ARGS__]); \
} while(0)
#else
#define NSLog(format, ...) do{ } while(0)
#endif


//Debug等级Log, 在此之前定义自己的NSLog
#ifdef LOG_LEVEL_DEBUG
#define DLog(format, ...) NSLog(@"<DEBUG>: %@", [NSString stringWithFormat:format, ##__VA_ARGS__])
#else
#define DLog(format, ...) do{ } while(0)
#endif

//Info等级Log
#ifdef LOG_LEVEL_INFO
#define ILog(format, ...) NSLog(@"<Info>: %@", [NSString stringWithFormat:format, ##__VA_ARGS__])
#else
#define ILog(format, ...) do{ } while(0)
#endif

//Error等级Log
#ifdef LOG_LEVEL_ERROR
#define ELog(format, ...) NSLog(@"<Error>: %@", [NSString stringWithFormat:format, ##__VA_ARGS__])
#else
#define ELog(format, ...) do{ } while(0)
#endif


#endif
