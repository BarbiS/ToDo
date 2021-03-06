//
//  Constants.h
//  ToDo
//
//  Created by Cubes School 3 on 4/15/16.
//  Copyright © 2016 Cubes School 3. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

// Macros
#define COLOR(r,g,b,a)                  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

// Colors
#define kOrangeColor                    COLOR(254.0, 172.0, 73.0, 1.0)
#define kPurpleColor                    COLOR(187.0, 114.0, 255.0, 1.0)
#define kTurquoiseColor                 COLOR(72.0, 211.0, 194.0, 1.0)
#define kDescPlaceholderColor           COLOR(29.0, 29.0, 38.0, 1.0)

// Enums
typedef  NS_ENUM(NSInteger, TaskGroup) {
    COMPLETED_TASK_GROUP = 1,
    NOT_COMPLETED_TASK_GROUP,
    IN_PROGRESS_TASK_GROUP
};

// User defaults
static NSString *const USER_IMAGE              = @"USER_IMAGE";
static NSString *const WALKTHROUGH_PRESENTED   = @"WALKTHROUGH_PRESENTED";
static NSString *const LOGED_IN                = @"LOGED_IN";


#endif /* Constants_h */

// Strings & numbers
#define ZERO_VALUE                     0.0

// Notifications
static NSString *const CITY_CHANGED             = @"CITY_CHANGED";
static NSString *const OK_STRING                = @"OK";
static NSString *const EMPTY_STRING             = @"";
static NSString *const SHOW_HOME                = @"SHOW_HOME";
static NSString *const SHOW_LOGIN               = @"SHOW_LOGIN";



// URLs
static NSString *const CUBES_URL               =@"http://www.cubes.rs";